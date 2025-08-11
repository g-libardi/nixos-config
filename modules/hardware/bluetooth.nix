{ config, lib, ... }:

with lib;

{
  config = mkMerge [
    # Set defaults
    {
      modules.hardware.bluetooth.powerOnBoot = mkDefault true;
    }
    
    # Conditional configuration
    (mkIf config.modules.hardware.bluetooth.enable {
      services.blueman.enable = true;
      
      hardware.bluetooth = {
        enable = true;
        powerOnBoot = config.modules.hardware.bluetooth.powerOnBoot;
        settings = {
          General = {
            experimental = true;  # show battery level
            
            # For controller
            Privacy = "device";
            JustWorksRepairing = "always";
            Class = "0x000100";
            FastConnectable = "true";
          };
        };
      };
    })
  ];
} 