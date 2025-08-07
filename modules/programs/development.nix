{ config, pkgs, lib, ... }:

with lib;

{
  config = mkIf config.modules.programs.development.enable {
    environment.systemPackages = with pkgs; [
      git
      gh
      direnv
      zellij
      code-cursor
    ] ++ optionals (builtins.elem "rust" config.modules.programs.development.languages) [
      rustup
    ] ++ optionals (builtins.elem "python" config.modules.programs.development.languages) [
      uv
    ] ++ optionals (builtins.elem "nodejs" config.modules.programs.development.languages) [
      deno
      nodejs
    ] ++ optionals (builtins.elem "go" config.modules.programs.development.languages) [
      go
    ] ++ optionals (builtins.elem "c" config.modules.programs.development.languages) [
      gcc
      portaudio
    ];

    # VirtualBox support
    virtualisation.virtualbox.host.enable = true;
    virtualisation.virtualbox.host.enableHardening = false;
    virtualisation.virtualbox.guest.enable = true;
    virtualisation.virtualbox.guest.dragAndDrop = true;

    users.extraGroups.vboxusers.members = [ config.modules.users.defaultUser ];

    # Development shell aliases
    environment.shellAliases = 
      let
        cmd1 = "zellij attach --create $(pwd | tr '/' '__')";
        cmd2 = "zellij attach --create $(realpath $1 | tr '/' '__')";
      in 
      {
        attach = "bash -c 'if [ -z \"$1\" ]; then ${cmd1}; else ${cmd2}; fi;' -- ";
      };
  };
} 