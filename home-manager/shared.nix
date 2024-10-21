{ config, pkgs, ... }@inputs:

{
  programs.home-manager.enable = true;

  imports = [
    ./dotfile_manager.nix
  ];

  home.packages = with pkgs; [
    nerdfonts
    tofi
    pamixer
    haruna
  ];
  
  # services.kdeconnect.enable = true;
  # services.kdeconnect.indicator = true;
}
