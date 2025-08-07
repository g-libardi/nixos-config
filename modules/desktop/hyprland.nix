{ config, pkgs, lib, ... }:

with lib;

{
  config = mkIf config.modules.desktop.hyprland.enable {
    # Load dotfiles
    file."/home/libardi/.config/hypr".source = "/home/libardi/nixos-config/dotfiles/hyprland/hypr";
    file."/home/libardi/.config/waybar".source = "/home/libardi/nixos-config/dotfiles/hyprland/waybar";
    file."/home/libardi/.config/tofi".source = "/home/libardi/nixos-config/dotfiles/hyprland/tofi";

    # Enable themeing for GTK and QT
    qt.style = "adwaita-dark";

    # Power management
    services.tlp.enable = true;
    services.tlp.settings = {
      CPU_ENERGY_PERF_POLICY_ON_AC="performance";
    };

    # Enable the hyprland NixOS module
    programs.hyprland.enable = true;
    programs.hyprland.xwayland.enable = true;
    services.hypridle.enable = true;
    programs.waybar.enable = true;
    
    environment.systemPackages = with pkgs; [
      tofi       # launcher
      hyprpolkitagent # polkit agent
      hypridle   # idle manager
      hyprshot   # screenshot tool
      libnotify  # notification daemon library
      hyprnotify # notification daemon
      gum        # tui utility
      overskride # bluetooth manager
      nwg-displays # display manager
      linux-wallpaperengine # wallpaper engine
    ];
  };
} 