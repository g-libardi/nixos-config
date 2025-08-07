{ config, pkgs, lib, ... }:

with lib;

{
  config = mkIf config.modules.security.secureboot.enable {
    # Disable systemd-boot when using secure boot
    boot.loader.systemd-boot.enable = mkForce false;

    # Enable lanzaboote for secure boot
    boot.lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };

    # Install sbctl for secure boot management
    environment.systemPackages = [ pkgs.sbctl ];
  };
} 