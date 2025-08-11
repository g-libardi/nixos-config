{ config, lib, ... }:

with lib;

{
  imports = [
    ../../lib/options.nix
    ./hyprland.nix
    ./qtile.nix
    ./wayland.nix
    ./x11.nix
  ];

  config = mkMerge [
    # Auto-enable desktop when any desktop module is enabled
    {
      modules.desktop.enable = mkIf (config.modules.desktop.hyprland.enable ||
                                     config.modules.desktop.qtile.enable) true;
      
      # Auto-enable appropriate display systems
      modules.desktop.wayland.enable = mkIf config.modules.desktop.hyprland.enable true;
      modules.desktop.x11.enable = mkIf config.modules.desktop.qtile.enable true;
    }
    
    # Desktop configuration when enabled
    (mkIf config.modules.desktop.enable {
      # Enable display manager
      services.displayManager.ly.enable = true;
      
      # Configure keymap
      services.xserver.xkb = {
        layout = "us";
        variant = "intl";
      };

      # Set the default session based on which DE is enabled
      services.displayManager.defaultSession =
        if config.modules.desktop.hyprland.enable then "hyprland"
        else if config.modules.desktop.qtile.enable then "qtile"
        else "";

      # Define environment variables for terminal
      environment.variables = { 
        TERM = "kitty"; 
        TERMINAL = "kitty"; 
      };
    })
  ];
} 