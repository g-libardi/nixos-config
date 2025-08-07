{ config, pkgs, lib, ... }:

with lib;

{
  config = mkIf config.modules.desktop.wayland.enable {
    # XDG portal configuration for Wayland
    xdg.portal = {
      enable = true;
      wlr.enable = true;
      config.common.default = "*";
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
    };

    # Enable Wayland support in applications
    environment.variables = {
      NIXOS_OZONE_WL = "1";  # Enable Wayland in Chromium/Electron apps
      MOZ_ENABLE_WAYLAND = "1";  # Enable Wayland in Firefox
    };

    # Security services
    security.polkit.enable = true;
  };
} 