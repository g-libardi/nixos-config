{ pkgs }:
let
    nvimPkg = pkgs.neovim-unwrapped.overrideAttrs (oldAttrs: {
        pname = "neovim-unwrapped-custom";
        version = "stable";  # Replace with the desired version
        src = pkgs.fetchFromGitHub {
            owner = "neovim";
            repo = "neovim";
            rev = "stable";  # Match the desired version here
            sha256 = "sha256-OsHIacgorYnB/dPbzl1b6rYUzQdhTtsJYLsFLJxregk=";  # You will need to fill in the hash
        };
    });

    runtimeDeps = [
        nvimPkg
        (pkgs.python311.withPackages (ps: with ps; [
            pynvim
            jupyter_client
            cairosvg
            pnglatex
            plotly
            kaleido
            pyperclip
            nbformat
            pillow
            ipykernel
        ]))
        pkgs.wget
        pkgs.unzip
        pkgs.curl
        pkgs.git
        pkgs.wl-clipboard
        pkgs.nodePackages_latest.nodejs
        pkgs.fd
        pkgs.ripgrep
        pkgs.lua5_1
        pkgs.lua51Packages.luarocks
        pkgs.cargo
        pkgs.imagemagick
        pkgs.luajitPackages.magick
    ];

    runtimeDepsDirs = pkgs.lib.concatStringsSep ":" (map (pkg: "${pkg}/bin") runtimeDeps);

in

pkgs.stdenv.mkDerivation rec {
    pname = "nvim";
    version = "stable";
    name = "libardi-nvim-${version}";

    buildInputs = runtimeDeps;
    propagatedBuildInputs = [ nvimPkg ];

    unpackPhase = ":";

    configurePhase = ":";

    installPhase = "
mkdir -p $out/bin
cat <<EOF > $out/bin/nvim
#!/bin/bash
PATH=$PATH:${runtimeDepsDirs} \
exec ${nvimPkg}/bin/nvim
EOF
chmod +x $out/bin/nvim
    ";
}
