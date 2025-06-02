{ config, pkgs, ... }:

{
  imports = [
      ./hardware-configuration.nix
  ];

  boot.supportedFilesystems = [ "exfat" ];

  fileSystems."/run/media/libardi/Files" = { # Or choose a more permanent mount point like /mnt/Games
    device = "/dev/disk/by-uuid/702b8095-01";
    fsType = "exfat";
    options = [
      "rw"
      "uid=1000" # Assuming libardi's UID is 1000
      "gid=100"  # Assuming users GID is 100
      "fmask=0022"
      "dmask=0022"
      "nofail"   # Important: don't halt boot if drive isn't present
      "auto"     # Mount automatically
      # You might choose to omit "errors=remount-ro" if you prefer to handle errors manually,
      # but it's generally a safe default. The key is to *fix* the errors when they occur.
      "errors=remount-ro"
    ];
  };
}