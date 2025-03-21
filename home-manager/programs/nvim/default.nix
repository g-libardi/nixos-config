{ pkgs, lib }:
let
    neovim-stable = pkgs.neovim-unwrapped.overrideAttrs (old: {
        pname = "neovim-stable";
        version = "stable";
        src = pkgs.fetchFromGitHub {
            owner = "neovim";
            repo = "neovim";
            rev = "stable";
            hash = "sha256-OsHIacgorYnB/dPbzl1b6rYUzQdhTtsJYLsFLJxregk=";
        };
        doInstallCheck = false;
    });

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
    ];

in pkgs.wrapNeovimUnstable neovim-stable {
        viAlias = true;
        vimAlias = true;
        withNodeJs = true;
        withPython3 = true;
        wrapRc = false;
        wrapperArgs = [
            "--prefix" "PATH" ":" (lib.makeBinPath runtimeDeps)
        ];
    }
