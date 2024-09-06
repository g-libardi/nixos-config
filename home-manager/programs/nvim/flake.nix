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
        packages.x86_64-linux.default = pkgs.stdenv.mkDerivation {
            name = "libardi-nvim";
            pname = "mynvim";
            version = "1.0.0";

            buildInputs = [
            pkgs.neovim
            pkgs.python3
            pkgs.wget
            pkgs.unzip
            pkgs.curl
            pkgs.git
            ];
            # propagatedBuildInputs = [ pkgs.python3 pkgs.wget pkgs.unzip pkgs.cur ];

            unpackPhase = ":";

            installPhase = "
mkdir -p $out/bin
cat <<EOF > $out/bin/mynvim
#!/bin/bash
PATH=$PATH:${pkgs.wget}/bin:${pkgs.unzip}/bin:${pkgs.python3}:${pkgs.git}:${pkgs.curl} exec ${pkgs.neovim}/bin/nvim
EOF
chmod +x $out/bin/mynvim
            ";
        };
        defaultPackage.x86_64-linux = self.packages.x86_64-linux.default;
    };
}

