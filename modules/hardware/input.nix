{ config, lib, ... }:

with lib;

{
  config = mkIf config.modules.hardware.input.enable {
    # Enable touchpad support
    services.libinput.enable = mkIf config.modules.hardware.input.touchpad true;
    
    # Enable gamepad support
    hardware.xpadneo.enable = mkIf config.modules.hardware.input.gamepad true;

    # Default settings based on host type
    modules.hardware.input = {
      touchpad = mkIf (config.host.type == "laptop") (mkDefault true);
      gamepad = mkDefault false;
    };
  };
} 