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
            ./hosts/${hn}
            inputs.musnix.nixosModules.musnix
            nix-link.nixosModules.nix-link
            
            # Secure Boot (only for desktop)
            lanzaboote.nixosModules.lanzaboote

            # Import the existing file utility
            ./lib/file.nix
          ];
        };
      };

      # Use fold to accumulate all attribute sets into a single one
      combinedConfigurations = nixpkgs.lib.foldl'
        (acc: value: nixpkgs.lib.attrsets.recursiveUpdate acc (makeNixosConfiguration value))
        {} hostNames;
    in
      {
      nixosConfigurations = combinedConfigurations;
    };
}

