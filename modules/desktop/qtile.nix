{ config, pkgs, lib, ... }:

with lib;

{
  config = mkIf config.modules.desktop.qtile.enable {
    services.xserver.windowManager.qtile = {
      enable = true;
      extraPackages = python3Packages: with python3Packages; [
        qtile-extras
      ];
    };

    environment.systemPackages = with pkgs; [
      linux-wallpaperengine
      xwinwrap
      polkit_gnome  # For polkit-gnome-authentication-agent-1
    ];

    # Enable autorandr for monitor management
    services.autorandr.enable = true;

    # Enable picom compositor
    services.picom.enable = true;
    
    # Load dotfiles
    file."/home/libardi/.config/qtile".source = "/home/libardi/nixos-config/dotfiles/qtile/qtile";
    file."/home/libardi/.config/picom".source = "/home/libardi/nixos-config/dotfiles/qtile/picom";
  };
} 