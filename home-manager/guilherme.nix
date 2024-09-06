{ config, pkgs, ... }@inputs:


let
    mynvim = import ./programs/nvim;
in
{
  home.username = "guilherme";
  home.homeDirectory = "/home/guilherme";
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    pkgs.gh
    pkgs.vscode-fhs
    pkgs.steam
    pkgs.qutebrowser
    pkgs.ticktick
    pkgs.microsoft-edge
    mynvim.packages.x86_64-linux.default
  ];


  programs.git = {
    enable = true;
    userName = "g-libardi";
    userEmail = "guilhermelibardi@hotmail.com";
  };
}
