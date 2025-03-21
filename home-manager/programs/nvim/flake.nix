{
    description = "Standalone Neovim flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    outputs = { self, nixpkgs, ... }:
    let
        system = "x86_64-linux";
        pkgs = import nixpkgs { system = system; };
        lib = pkgs.lib;
    in {
        packages.x86_64-linux.default = import ./default.nix { inherit pkgs; inherit lib; };
        defaultPackage.x86_64-linux = self.packages.x86_64-linux.default;
    };
}

