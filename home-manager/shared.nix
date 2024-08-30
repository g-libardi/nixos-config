{ config, pkgs, ... }@inputs:

{
  programs.home-manager.enable = true;

  imports = [
    ./dotfile_manager.nix
  ];

  home.packages = with pkgs; [
    neovim
    gh
    vscode-fhs
    foot
    swaybg
    swayosd
    swaynotificationcenter
    steam
    qutebrowser
    nerdfonts
    tofi
    ticktick
  ];
  

  # hyprland config
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.extraConfig = "
    source = ${config.home.homeDirectory}/nixos-config/home-manager/hypr/hyprland.conf
    $U_NIX_CONFIG = ${builtins.getEnv "U_NIX_CONFIG"}
  ";
  programs.waybar.enable = true;  
}
