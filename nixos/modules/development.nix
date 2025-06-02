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

    virtualisation.virtualbox.host.enable = true;
    virtualisation.virtualbox.host.enableHardening = false;
    virtualisation.virtualbox.guest.enable = true;
    virtualisation.virtualbox.guest.dragAndDrop = true;

    users.extraGroups.vboxusers.members = [ "libardi" ];

    environment.shellAliases = 
        let
            cmd1 = "zellij attach --create $(pwd | tr '/' '__')";
            cmd2 = "zellij attach --create $(realpath $1 | tr '/' '__')";
        in 
        {
            attach = "bash -c 'if [ -z \"$1\" ]; then ${cmd1}; else ${cmd2}; fi;' -- ";
        };
}
