{ config, pkgs, lib, ... }:

with lib;

{
  config = mkIf config.modules.users.enable {
    # Base system packages available to all users
    environment.systemPackages = with pkgs; [
      vim
      neovim
      brave
      nautilus
      nwg-look
      lxqt.lxqt-policykit
      udiskie
      networkmanagerapplet
      wlogout
      swww
      clipse
      wl-clipboard
      librewolf
      kitty
      zen-browser
    ];

    # Optional services for better desktop experience
    # services.udisks2.enable = true;
    # services.gvfs.enable = true;
  };
} 