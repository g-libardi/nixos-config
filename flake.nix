{
  description = "My NixOS configuration! :)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    musnix = {
      url = "github:musnix/musnix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-link = {
      url = "github:g-libardi/nix-link/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-link, lanzaboote, zen, ... } @ inputs:
    let
      hostNames = [ "desktop" "laptop" ];
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
        ];
      };
      lib = pkgs.lib;
      pkgsOverlays = { ... }: {
        nixpkgs.overlays = [
          (_: _: {
            zen-browser = inputs.zen.packages.${system}.default;
          })
        ];
      };

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
            ./nixos/programs
            ./nixos/desktop_env
            inputs.musnix.nixosModules.musnix
            nix-link.nixosModules.nix-link

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

