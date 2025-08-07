{ config, lib, ... }:

with lib;

{
  imports = [
    ../default.nix
    ./hardware.nix
  ];

  # Host identification
  host = {
    type = "desktop";
    profiles = [ "development" "gaming" ];
  };

  # Enable desktop environment
  modules = {
    desktop.hyprland.enable = true;
    
    # Hardware configuration
    hardware = {
      graphics = {
        enable = true;
        nvidia = true;
      };
      audio.enable = true;
      bluetooth.enable = true;
      input.enable = true;
    };
    
    # Services
    services = {
      printing = true;
      media = true;
      docker = true;
    };
    
    # Programs
    programs = {
      development = {
        enable = true;
        languages = [ "rust" "python" "nodejs" "c" "go" ];
      };
      nvim.enable = true;
      terminal.enable = true;
    };
    
    # Security
    security = {
      firewall.enable = true;
      secureboot.enable = true;
    };
  };
} 