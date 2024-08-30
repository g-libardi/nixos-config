{ config, pkgs, ... }@inputs:

{
  programs.home-manager.enable = true;

  imports = [
    ./dotfile_manager.nix
  ];

  home.packages = with pkgs; [
    foot
    swaybg
    swaynotificationcenter
    nerdfonts
    tofi
  ];
  
  # hyprland config
  # wayland.windowManager.hyprland.enable = true;
  # wayland.windowManager.hyprland.extraConfig = "
  #   source = ${config.home.homeDirectory}/nixos-config/home-manager/hypr/hyprland.conf
  # ";
  programs.waybar.enable = true;  
}
