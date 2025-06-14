{ config, pkgs, ... }:

{
    # Install firefox.
    # programs.firefox.enable = true;
    programs.kdeconnect.enable = true;
    programs.dconf.enable = true;
    programs.nix-ld.enable = true;

    # Docker
    virtualisation.docker.enable = true;
    users.extraGroups.docker.members = [ "libardi" ];

    # ADB
    programs.adb.enable = true;
    users.extraGroups.adbusers.members = [ "libardi" ];
    users.extraGroups.plugdev.members = [ "libardi" ];
    users.extraGroups.kvm.members = [ "libardi" ];
    services.udev.packages = [ pkgs.android-udev-rules ];

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        vim
        neovim
        brave
        nautilus
        nwg-look
        lxqt.lxqt-policykit
        udiskie
        networkmanagerapplet
        wlogout
        swww
        clipse
        wl-clipboard
        librewolf
        kitty
    ];


    # auto-detect and mount drives
    # services.udisks2.enable = true;
    # services.gvfs.enable = true;


    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };
}
