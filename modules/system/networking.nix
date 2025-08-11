{ config, lib, g, ... }:

with lib;

{
  config = mkMerge [
    # Set defaults
    {
      modules.system.networking.networkmanager = mkDefault true;
    }
    
    # Conditional configuration
    (mkIf config.modules.system.networking.enable {
      # Set hostname from global configuration
      networking.hostName = g.hostName;
      
      # Enable NetworkManager when specifically requested
      networking.networkmanager.enable = mkIf config.modules.system.networking.networkmanager true;
    })
  ];
} 