{ config, pkgs, ... }@inputs:

{
  home.username = "guilherme";
  home.homeDirectory = "/home/guilherme";
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    neovim
    gh
    vscode-fhs
    steam
    qutebrowser
    ticktick
    microsoft-edge
  ];

  programs.git = {
    enable = true;
    userName = "g-libardi";
    userEmail = "guilhermelibardi@hotmail.com";
  };
}