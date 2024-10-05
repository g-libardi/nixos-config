{ config, pkgs, ... }@inputs:

{
  programs.home-manager.enable = true;

  imports = [
    ./dotfile_manager.nix
  ];

  home.packages = with pkgs; [
    zellij
    nerdfonts
    tofi
    pamixer
    haruna
  ];
  
  # services.kdeconnect.enable = true;
  # services.kdeconnect.indicator = true;
}
