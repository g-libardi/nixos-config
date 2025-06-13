{ config, pkgs, ... }:

{
  imports = [
      ./hardware-configuration.nix
  ];

  boot.supportedFilesystems = [ "exfat" ];

  fileSystems."/mnt/Files" = { # Or choose a more permanent mount point like /mnt/Games
    device = "/dev/disk/by-uuid/843a5b5b-429b-4ffe-adab-aaa0daadbf7d";
    fsType = "ext4";
    options = [
      "defaults"  # Use default mount options
      "nofail"   # Important: don't halt boot if drive isn't present
      "errors=remount-ro"
    ];
  };
}
