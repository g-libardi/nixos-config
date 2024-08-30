{ config, pkgs, ... }@inputs:

{

  # home-manager stuff
  home.username = "guilherme";
  home.homeDirectory = "/home/guilherme";
  home.stateVersion = "24.05";
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
    walker
    qutebrowser
    nerdfonts
  ];
  

  # hyprland config
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.extraConfig = "
    source = ${config.home.homeDirectory}/nixos-config/home-manager/hypr/hyprland.conf
    $U_NIX_CONFIG = ${builtins.getEnv "U_NIX_CONFIG"}
  ";
  wayland.windowManager.hyprland.plugins = [
    # pkgs.hyprlandPlugins.hyprbars
  ];
  programs.waybar.enable = true;  


  programs.git = {
    enable = true;
    userName = "g-libardi";
    userEmail = "guilhermelibardi@hotmail.com";
  };

  

  # neovim config
  # home.file.".config/nvim" = {
  #   source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/home-manager/nvim";
  #   recursive = true;
  # };


}
