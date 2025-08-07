{ config, lib, ... }:

with lib;

{
  imports = [
    ../default.nix
    ./hardware.nix
  ];

  # Host identification
  host = {
    type = "laptop";
    profiles = [ "development" ];
  };

  # Enable desktop environment
  modules = {
    desktop.hyprland.enable = true;
    
    # Hardware configuration
    hardware = {
      graphics = {
        enable = true;
        intel = true;  # Assuming Intel graphics for laptop
      };
      audio.enable = true;
      bluetooth.enable = true;
      input = {
        enable = true;
        touchpad = true;
      };
    };
    
    # Services
    services = {
      printing = true;
      media = true;
    };
    
    # Programs
    programs = {
      development = {
        enable = true;
        languages = [ "rust" "python" "nodejs" ];
      };
      nvim.enable = true;
      terminal.enable = true;
    };
    
    # Security
    security = {
      firewall = {
        enable = true;
        strictMode = true;  # More strict firewall for laptop
      };
    };
  };
} 