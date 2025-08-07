{ config, lib, g, ... }:

with lib;

{
  config = mkIf config.modules.system.networking.enable {
    # Set hostname from global configuration
    networking.hostName = g.hostName;
    
    # Enable NetworkManager when specifically requested
    networking.networkmanager.enable = mkIf config.modules.system.networking.networkmanager true;
    
    # Default to NetworkManager for most systems
    modules.system.networking.networkmanager = mkDefault true;
  };
} 