{ pkgs, lib }:
let
    pythonEnv = pkgs.python311.withPackages (ps: with ps; [
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
    ]);

    runtimeDeps = [
        pkgs.fd
        pkgs.ripgrep
        pkgs.nodePackages_latest.nodejs
        pkgs.lua5_1
        pkgs.go
        pkgs.wl-clipboard
        pkgs.imagemagick
        pkgs.git
    ];

in pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped {
        viAlias = true;
        vimAlias = true;
        withNodeJs = true;
        withPython3 = true;
        wrapRc = false;
        wrapperArgs = [
            "--prefix" "PATH" ":" (lib.makeBinPath runtimeDeps)
        ];
    }
