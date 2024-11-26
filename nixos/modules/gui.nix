{ config, pkgs, ... }:

{

    # Configure keymap in X11
    services.xserver.xkb = {
        layout = "us";
        variant = "intl";
    };


    # Enable themeing for GTK and QT
    qt.style = "adwaita-dark";
    xdg.portal = {
        enable = true;
        wlr.enable = true;
        config.common.default = "*";
        extraPortals = with pkgs; [
            xdg-desktop-portal-wlr
            xdg-desktop-portal-gtk
        ];
    };


    services.tlp.enable = true;
    services.tlp.settings = {
        CPU_ENERGY_PERF_POLICY_ON_AC="performance";
    };


    # Enable the hyprland NixOS module
    programs.hyprland.enable = true;
    programs.hyprland.xwayland.enable = true;
    services.hypridle.enable = true;
    programs.waybar.enable = true;
    programs.foot.enable = true;
    environment.systemPackages = [
        pkgs.hypridle   # idle manager
        pkgs.hyprshot   # screenshot tool
        pkgs.hyprpanel  # panel
        pkgs.libnotify  # notification daemon library
        pkgs.hyprnotify # notification daemon
        pkgs.gum        # tui utility
    ];


    # define environment variable for terminal
    environment.variables = { TERM = "kitty"; TERMINAL = "kitty"; };


    # Enable the Gnome Display Manager
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.displayManager.gdm.wayland = true;
    services.displayManager.defaultSession = "hyprland";


    # Enable the X11 windowing system.
    services.xserver.enable = true;
}
