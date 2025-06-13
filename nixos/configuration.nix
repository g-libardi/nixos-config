{ config, pkgs, g, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware/${g.hostName}/default.nix
    ./modules/system.nix
    ./modules/services.nix
    ./modules/users.nix
    ./modules/packages.nix
    ./modules/development.nix
    ./modules/firewall.nix
    (if g.hostName == "desktop" then
      ./modules/nvidia.nix
    else
      ./modules/null.nix)
    ../lib/file.nix
  ];

  desktop_env = {
    hyprland = true;
    qtile = false;
  };

  # custom alias for system rebuild
  environment.shellAliases = {
    rebuild = "sudo nixos-rebuild switch --flake /home/libardi/nixos-config/.";
  };

  nixpkgs.config = let
    unstableTarball = fetchTarball
      "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
  in {
    packageOverrides = pkgs: {
      unstable = import unstableTarball { config = config.nixpkgs.config; };
    };
  };

  # --- Enable nix language dev utils ---
  # nix-index
  programs.nix-index.enable = true;
  programs.command-not-found.enable = false;  # Disable command-not-found to avoid conflict with nix-index

  # nix-fmt and nix-lsp
  environment.systemPackages = with pkgs; [ nixfmt nil ];

  # --- Auto-update nixpkgs ---
  # !TODO: Add auto-update nixpkgs

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
