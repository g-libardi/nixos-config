{
  description = "My NixOS configuration! :)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs: 
    let
      lib = nixpkgs.lib;
      hostNames = [ "desktop" "laptop" ];

      # This function will create an attrset for a given value
      makeNixosConfiguration = hn: {
        ${hn} = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          specialArgs = {
            g = import ./globals.nix // { hostName = hn; };
          };

          modules = [
            ./nixos/configuration.nix
            # ./lib/mkOutOfStoreSymLink.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.sharedModules = [
                ./home-manager/shared.nix
              ];
              home-manager.users.libardi = ./home-manager/libardi.nix;
            }
          ];
        };
      };

      # Use fold to accumulate all attribute sets into a single one
      combinedConfigurations = lib.foldl' (acc: value: lib.attrsets.recursiveUpdate acc (makeNixosConfiguration value)) {} hostNames;
    in 
      {
      nixosConfigurations = combinedConfigurations;
    };
}
