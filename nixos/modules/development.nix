{ pkgs, config, ... }:

{
    environment.systemPackages = with pkgs; [
        git
        gh
        rustup
        uv
        deno
        nodejs
        gcc
        zellij
        go
        portaudio
        code-cursor
        direnv
    ];

    environment.shellAliases = 
        let
            cmd1 = "zellij attach --create $(pwd | tr '/' '__')";
            cmd2 = "zellij attach --create $(realpath $1 | tr '/' '__')";
        in 
        {
            attach = "bash -c 'if [ -z \"$1\" ]; then ${cmd1}; else ${cmd2}; fi;' -- ";
        };
}
