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
    pkgs.vesktop
    (import ./programs/nvim { inherit pkgs; lib=inputs.lib; }) 
  ];


  programs.git = {
    enable = true;
    userName = "g-libardi";
    userEmail = "contato@libardi.dev.br";
  };
}
