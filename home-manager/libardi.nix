{ config, pkgs, ... }@inputs:

{
  home.username = "libardi";
  home.homeDirectory = "/home/libardi";
  home.stateVersion = "24.05";

  home.packages = [
    pkgs.gh
    pkgs.vscode-fhs
    pkgs.steam
    pkgs.qutebrowser
    pkgs.ticktick
    pkgs.microsoft-edge
    pkgs.discord
    (import ./programs/nvim { inherit pkgs; }) 
  ];


  programs.git = {
    enable = true;
    userName = "g-libardi";
    userEmail = "contato@libardi.dev.br";
  };
}
