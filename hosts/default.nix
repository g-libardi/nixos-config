{ config, lib, ... }:

with lib;

{
  imports = [
    ../lib/options.nix
    ../modules
    ../profiles
  ];

  config = {
    # Auto-enable core modules for all hosts
    modules = {
      system.boot.enable = mkDefault true;
      system.networking.enable = mkDefault true;
      system.locale.enable = mkDefault true;
      system.shell.enable = mkDefault true;
      system.nix.enable = mkDefault true;
      users.enable = mkDefault true;
    };

    # Set system state version
    system.stateVersion = "24.05";

    # Common shell aliases
    environment.shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ${config.modules.system.nix.flakePath}";
    };

    # Enable nix-link by default
    nix-link.enable = mkDefault true;
  };
} 