{ config, pkgs, ... }:

{
  # home-manager stuff
  home.username = "guilherme";
  home.homeDirectory = "/home/guilherme";
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;


  home.packages = with pkgs; [
    neovim
    gh
    vscode-fhs
    foot
    swaybg
    swayosd
    steam
    walker
    qutebrowser
  ];
  

  # hyprland config
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.extraConfig = "
    source = ${config.home.homeDirectory}/nixos-config/home-manager/hypr/hyprland.conf
  ";
  wayland.windowManager.hyprland.plugins = [
    # pkgs.hyprlandPlugins.hyprbars
  ];
  programs.waybar.enable = true;  
  
  
  # gtk theme
  # gtk = {
  #   enable = true;
  #   theme.name = "Adwaita";
  #   theme.package = pkgs.gnome.gnome-themes-extra;
  # };


  programs.git = {
    enable = true;
    userName = "g-libardi";
    userEmail = "guilhermelibardi@hotmail.com";
  };

  

  # neovim config
  home.file.".config/nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/home-manager/nvim";
    recursive = true;
  };


}
