{ config, pkgs, g, ... }:

{
    imports = [
        # Include the results of the hardware scan.
        ./hardware/${g.hostName}/hardware-configuration.nix
        ./modules/system.nix
        ./modules/services.nix
        ./modules/users.nix
        ./modules/packages.nix
        ./modules/gui.nix
        ./modules/development.nix
        ./modules/firewall.nix
        (if g.hostName == "desktop" then ./modules/nvidia.nix else ./modules/null.nix)
        # ./programs/games.nix
        # ./modules/cowsay/default.nix
        ];

    # custom alias for system rebuild
    environment.shellAliases = {
        rebuild = "sudo nixos-rebuild switch --flake /home/libardi/nixos-config/.";
    };


    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "24.05"; # Did you read the comment?


    # NOTE: The following lines are tests only
    nix-link.enable = true;
}
