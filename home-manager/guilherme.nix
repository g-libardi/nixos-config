{ config, pkgs, ... }:

{
  home.username = "guilherme";
  home.homeDirectory = "/home/guilherme";


  home.packages = with pkgs; [
    neovim
    git
    gh
    vscode-fhs
  ];
  

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


  # home-manager stuff
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
