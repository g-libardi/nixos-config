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

    imports = [
        # lib.mkIf config.desktop_env.hyprland ./hyprland/default.nix
        ./hyprland/default.nix
    ];
}
