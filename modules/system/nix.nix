{ config, lib, g, pkgs, ... }:

with lib;

{
  config = mkIf config.modules.system.nix.enable {
    # Enable nix-command and flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    
    # Nix optimization
    nix.optimise = mkIf config.modules.system.nix.garbageCollection {
      automatic = true;
      dates = ["daily"];
    };

    # Garbage collection
    nix.gc = mkIf config.modules.system.nix.garbageCollection {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    # Auto-upgrade system
    system.autoUpgrade = mkIf config.modules.system.nix.autoUpgrade {
      enable = true;
      dates = "daily";
      flake = config.modules.system.nix.flakePath;
    };

    # Nix development tools
    programs.nix-index.enable = true;
    programs.command-not-found.enable = false;  # Avoid conflict with nix-index

    environment.systemPackages = with pkgs; [ 
      nixfmt-classic 
      nil 
    ];

    # Environment variables
    environment.variables = {
      U_NIX_CONFIG = "/home/guilherme/nixos-config";
      NIXOS_OZONE_WL = "1";
    };

    # Default settings
    modules.system.nix = {
      garbageCollection = mkDefault true;
      autoUpgrade = mkDefault true;
    };
  };
} 