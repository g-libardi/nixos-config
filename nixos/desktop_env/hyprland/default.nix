{ config, pkgs, ... }:

{
    # Load dotfiles
    file."/home/libardi/.config/hypr".source = "/home/libardi/nixos-config/nixos/desktop_env/hyprland/dotfiles/hypr";
    file."/home/libardi/.config/waybar".source = "/home/libardi/nixos-config/nixos/desktop_env/hyprland/dotfiles/waybar";
    file."/home/libardi/.config/tofi".source = "/home/libardi/nixos-config/nixos/desktop_env/hyprland/dotfiles/tofi";

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
    environment.systemPackages = [
        pkgs.tofi
        pkgs.hyprpolkitagent # polkit agent
        pkgs.hypridle   # idle manager
        pkgs.hyprshot   # screenshot tool
        pkgs.libnotify  # notification daemon library
        pkgs.hyprnotify # notification daemon
        pkgs.gum        # tui utility
        pkgs.overskride # bluetooth manager
        pkgs.nwg-displays # display manager
        pkgs.linux-wallpaperengine # wallpaper engine
    ];


    # define environment variable for terminal
    environment.variables = { TERM = "kitty"; TERMINAL = "kitty"; };


    # Enable the Gnome Display Manager
    services.displayManager.ly.enable = true;
    services.displayManager.defaultSession = "hyprland";


    # Enable the X11 windowing system.
    services.xserver.enable = true;
}

