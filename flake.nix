{
  description = "My NixOS configuration! :)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    musnix.url = "github:musnix/musnix";
    nix-link.url = "github:g-libardi/nix-link/main";
  };

  outputs = { self, nixpkgs, home-manager, nix-link, lanzaboote, ... } @ inputs:
    let
      hostNames = [ "desktop" "laptop" ];
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
        ];
      };
      lib = pkgs.lib;
      pkgsOverlays = (inputs: {
        nixpkgs.overlays = [
        ];
      });

      # This function will create an attrset for a given value
      makeNixosConfiguration = hn: {
        ${hn} = nixpkgs.lib.nixosSystem {
          system = system;

          specialArgs = {
            g = import ./globals.nix // { hostName = hn; };
            musnix = inputs.musnix;
          };

          modules = [
            pkgsOverlays
            ./nixos/configuration.nix
            # ./lib/mkOutOfStoreSymlink.nix
            inputs.musnix.nixosModules.musnix
            nix-link.nixosModules.nix-link
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.sharedModules = [
                ./home-manager/shared.nix
              ];
              home-manager.users.libardi = ./home-manager/libardi.nix;
            }

            # Secure Boot
            lanzaboote.nixosModules.lanzaboote

            ({ pkgs, lib, ... }: 
            if hn != "desktop" then {
            } else
            {

              environment.systemPackages = [
                pkgs.sbctl
              ];
              boot.loader.systemd-boot.enable = lib.mkForce false;

              boot.lanzaboote = {
                enable = true;
                pkiBundle = "/etc/secureboot";
              };
            })

          ];
        };
      };

      # Use fold to accumulate all attribute sets into a single one
      combinedConfigurations = lib.foldl'
        (acc: value: lib.attrsets.recursiveUpdate acc (makeNixosConfiguration value))
        {} hostNames;
    in
      {
      nixosConfigurations = combinedConfigurations;
    };
}

