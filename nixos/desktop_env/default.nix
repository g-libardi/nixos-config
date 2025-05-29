{ config, pkgs, lib, ... }:

with lib;

{
    options.desktop_env = {
        hyprland = mkOption {
            type = types.bool;
            default = false;
            description = "Enable Hyprland desktop environment";
        };
        qtile = mkOption {
            type = types.bool;
            default = false;
            description = "Enable Qtile desktop environment";
        };
    };

    config = {
        # Enable the Display Manager
        services.displayManager.ly.enable = true;
        services.autorandr.enable = config.desktop_env.qtile;

        # Set the default session based on which DE is enabled
        services.displayManager.defaultSession =
            if config.desktop_env.hyprland then "hyprland"
            else if config.desktop_env.qtile then "qtile"
            else "";

        # Configure keymap in X11
        services.xserver.xkb = {
            layout = "us";
            variant = "intl";
        };

        # Enable the X11 windowing system.
        services.xserver.enable = true;

        # define environment variable for terminal
        environment.variables = { TERM = "kitty"; TERMINAL = "kitty"; };
    };

    imports = [
        ./hyprland/default.nix
        ./qtile/default.nix
    ];
}
