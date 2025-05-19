{ pkgs, ... }:
{
    services.xserver.windowManager.qtile = {
        enable = true;
        extraPackages = python3Packages: with python3Packages; [
            qtile-extras
        ];
    };

    environment.systemPackages = [
        pkgs.linux-wallpaperengine
        pkgs.xwinwrap
        pkgs.polkit_gnome  # For polkit-gnome-authentication-agent-1
    ];

    security.polkit.enable = true;
    security.soteria.enable = true;

    services.picom.enable = true;
    file."/home/libardi/.config/qtile".source = "/home/libardi/nixos-config/nixos/desktop_env/qtile/dotfiles/qtile";
    file."/home/libardi/.config/picom".source = "/home/libardi/nixos-config/nixos/desktop_env/qtile/dotfiles/picom";
}
