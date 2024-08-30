{ config, pkgs, ... }@inputs:

{
  home.username = "guilherme";
  home.homeDirectory = "/home/guilherme";
  home.stateVersion = "24.05";

  programs.git = {
    enable = true;
    userName = "g-libardi";
    userEmail = "guilhermelibardi@hotmail.com";
  };
}