{ pkgs }:
pkgs.stdenv.mkDerivation {
    name = "libardi-nvim";
    pname = "nvim";
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
cat <<EOF > $out/bin/nvim
#!/bin/bash
PATH=$PATH:${pkgs.wget}/bin:${pkgs.unzip}/bin:${pkgs.python3}:${pkgs.git}:${pkgs.curl} exec ${pkgs.neovim}/bin/nvim
EOF
chmod +x $out/bin/nvim
    ";
}
