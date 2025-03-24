{ config, pkgs, ... }@inputs:

{
    environment.systemPackages = [
        (import ./package.nix { inherit pkgs; lib=pkgs.lib; })
    ];
    file."/home/libardi/.config/nvim".source = "/home/libardi/nixos-config/nixos/programs/nvim/dotfiles";
}
