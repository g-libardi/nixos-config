{ pkgs }:
pkgs.stdenv.mkDerivation rec {
    pname = "nvim";
    version = "1.0.0";
    name = "libardi-nvim-${version}";

    buildInputs = [
        (pkgs.neovim.overrideAttrs (oldAttrs: {
            version = "v0.10.1";  # Replace with the desired version
            src = pkgs.fetchFromGitHub {
                owner = "neovim";
                repo = "neovim";
                rev = "v0.10.1";  # Match the desired version here
                sha256 = "sha256-OsHIacgorYnB/dPbzl1b6rYUzQdhTtsJYLsFLJxregk=";  # You will need to fill in the hash
            };
        }))
        pkgs.python3
        pkgs.wget
        pkgs.unzip
        pkgs.curl
        pkgs.git
        pkgs.wl-clipboard
        ];
    # propagatedBuildInputs = [ pkgs.python3 pkgs.wget pkgs.unzip pkgs.cur ];

    unpackPhase = ":";

    installPhase = "
mkdir -p $out/bin
cat <<EOF > $out/bin/nvim
#!/bin/bash
PATH=$PATH:${pkgs.wget}/bin:${pkgs.unzip}/bin:${pkgs.python3}:${pkgs.git}:${pkgs.curl}:${pkgs.wl-clipboard} exec ${pkgs.neovim}/bin/nvim
EOF
chmod +x $out/bin/nvim
    ";
}
