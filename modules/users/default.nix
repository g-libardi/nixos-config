{ config, pkgs, lib, ... }:

with lib;

{
  imports = [
    ../../lib/options.nix
    ./profiles.nix
  ];

  config = mkIf config.modules.users.enable {
    # Define the default user account
    users.users.${config.modules.users.defaultUser} = {
      isNormalUser = true;
      description = "Default User";
      extraGroups = [ "networkmanager" "wheel" ];
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # Enable common programs
    programs.kdeconnect.enable = true;
    programs.dconf.enable = true;
    programs.nix-ld.enable = true;

    # ADB support
    programs.adb.enable = true;
    users.extraGroups.adbusers.members = [ config.modules.users.defaultUser ];
    users.extraGroups.plugdev.members = [ config.modules.users.defaultUser ];
    users.extraGroups.kvm.members = [ config.modules.users.defaultUser ];
    services.udev.packages = [ pkgs.android-udev-rules ];

    # Auto-enable users when any other module needs user configuration
    modules.users.enable = mkDefault true;
  };
} 