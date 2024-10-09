{ config, pkgs, ... }:

{
    # # use i3 as wm
    # services.xserver.enable = true;
    # services.xserver.windowManager.i3 = {
    #     enable = true;
    #     extraPackages = with pkgs; [
    #         rofi
    #         i3status  # gives you the default i3 status bar
    #         i3lock  # default i3 screen locker
    #         i3blocks  # if you are planning on using i3blocks over i3status
    #     ];
    # };
    #
    # # i3 auxillary programs
    # environment.systemPackages = with pkgs; [ dunst libnotify picom xwinwrap mpv ];

    # Configure keymap in X11
    services.xserver.xkb = {
        layout = "us";
        variant = "intl";
    };

    # qt.style = "adwaita-dark";
    # xdg.portal = {
    #     enable = true;
    #     config.common.default = "*";
    #     extraPortals = with pkgs; [
    #         xdg-desktop-portal-wlr
    #         xdg-desktop-portal-gtk
    #     ];
    # };

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
        pkgs.libnotify  # notification daemon
        pkgs.hypridle  # idle manager
        pkgs.hyprshot  # screenshot tool
  ];
  
  # define environment variable for terminal
  environment.variables = { TERM = "foot"; TERMINAL = "foot"; };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.wlr.enable = true;


  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  services.displayManager.defaultSession = "hyprland";


  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.wayland.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

}
