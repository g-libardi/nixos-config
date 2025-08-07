{ config, lib, ... }:

with lib;

{
  config = mkIf config.modules.desktop.x11.enable {
    # Enable the X11 windowing system
    services.xserver.enable = true;

    # Security services
    security.polkit.enable = true;
    security.soteria.enable = true;
  };
} 