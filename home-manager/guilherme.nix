{ config, pkgs, ... }@inputs:

{
  home.username = "guilherme";
  home.homeDirectory = "/home/guilherme";
  home.stateVersion = "24.05";

  home.packages = [
    pkgs.gh
    pkgs.vscode-fhs
    pkgs.steam
    pkgs.qutebrowser
    pkgs.ticktick
    pkgs.microsoft-edge
    (import ./programs/nvim { inherit pkgs; }) 
  ];


  programs.git = {
    enable = true;
    userName = "g-libardi";
    userEmail = "guilhermelibardi@hotmail.com";
  };
}
