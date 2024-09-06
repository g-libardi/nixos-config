{
    description = "Standalone Neovim flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    };

    outputs = { self, nixpkgs, ... }:
    let
        system = "x86_64-linux";
        pkgs = import nixpkgs { system = system; };
    in {
        packages.x86_64-linux.default = import ./default.nix { pkgs=pkgs; };
        defaultPackage.x86_64-linux = self.packages.x86_64-linux.default;
    };
}

