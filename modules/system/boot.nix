{ config, pkgs, lib, ... }:

with lib;

{
  config = mkIf config.modules.system.boot.enable {
    # Bootloader configuration
    boot.loader.systemd-boot.enable = mkDefault true;
    boot.loader.efi.canTouchEfiVariables = true;
    
    # Enable NTFS support
    boot.supportedFilesystems = [ "ntfs" ];
    
    # For Steam and 32-bit applications
    hardware.graphics.enable32Bit = true;
    services.pulseaudio.support32Bit = true;
    
    # Virtual camera support for OBS
    boot.extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
    boot.extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';
  };
} 