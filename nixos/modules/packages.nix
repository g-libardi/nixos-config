{ config, pkgs, ... }:

{
    # Install firefox.
    programs.firefox.enable = true;
    programs.kdeconnect.enable = true;
    programs.dconf.enable = true;
    programs.nix-ld.enable = true;

    # Docker
    virtualisation.docker.enable = true;

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        vim
        gnome.nautilus
        nwg-look
        lxqt.lxqt-policykit
        udiskie
        networkmanagerapplet
        wlogout
        swww
        clipse
        wl-clipboard
        librewolf

        #  wget
    ];

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };
}
