{ config, pkgs, ... }@inputs:

{
  programs.home-manager.enable = true;

  imports = [
    ./dotfile_manager.nix
  ];

  home.packages = with pkgs; [
    foot
    zellij
    swaybg
    swaynotificationcenter
    hyprshot
    nerdfonts
    tofi
    pamixer
    haruna
  ];
  
  # hyprland config
  # wayland.windowManager.hyprland.enable = true;
  # wayland.windowManager.hyprland.extraConfig = "
  #   source = ${config.home.homeDirectory}/nixos-config/home-manager/hypr/hyprland.conf
  # ";
  programs.waybar.enable = true;  
  # services.kdeconnect.enable = true;
  # services.kdeconnect.indicator = true;
}
