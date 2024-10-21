{ pkgs, config, ... }:

{
    environment.systemPackages = with pkgs; [
        rustup
        uv
        deno
        gcc
        zellij
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
