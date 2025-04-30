{ config, pkgs, lib, ... }:

{
    # desktop_env = {
    #     hyprland = lib.mkOption {
    #         type = lib.types.bool;
    #         default = false;
    #     };
    #     i3 = lib.mkOption {
    #         type = lib.types.bool;
    #         default = false;
    #     };
    # };

    # Enable the Display Manager
    services.displayManager.ly.enable = true;
    services.displayManager.defaultSession = "hyprland";

    # Configure keymap in X11
    services.xserver.xkb = {
        layout = "us";
        variant = "intl";
    };

    # Enable the X9 windowing system.
    services.xserver.enable = true;

    imports = [
        # lib.mkIf config.desktop_env.hyprland ./hyprland/default.nix
        # ./hyprland/default.nix
        ./qtile/default.nix
    ];
}
