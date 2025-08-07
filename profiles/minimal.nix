{ config, lib, pkgs, ... }:

with lib;

{
  config = mkIf (builtins.elem "minimal" config.host.profiles) {
    # Minimal system packages
    environment.systemPackages = with pkgs; [
      # Essential utilities
      vim
      curl
      wget
      git
      
      # Basic file management
      file
      tree
      
      # Network tools
      ping
      
      # Text processing
      grep
      sed
      awk
    ];
    
    # Disable non-essential services
    services = {
      printing.enable = mkForce false;
      bluetooth.enable = mkForce false;
    };
    
    # Minimal hardware configuration
    modules = {
      hardware = {
        bluetooth.enable = mkForce false;
      };
      
      services = {
        printing = mkForce false;
        media = mkForce false;
        docker = mkForce false;
        virtualization = mkForce false;
      };
    };
    
    # Aggressive power management for minimal systems
    powerManagement = {
      enable = true;
      cpuFreqGovernor = "powersave";
    };
  };
} 