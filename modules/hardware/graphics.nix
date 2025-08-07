{ config, pkgs, lib, ... }:

with lib;

{
  config = mkIf config.modules.hardware.graphics.enable {
    # Enable OpenGL/graphics
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    # NVIDIA configuration
    services.xserver.videoDrivers = mkIf config.modules.hardware.graphics.nvidia ["nvidia"];
    
    environment.variables = mkIf config.modules.hardware.graphics.nvidia {
      "WLR_NO_HARDWARE_CURSORS" = "1";
      "GBM_BACKEND" = "nvidia-drm";
      "__GLX_VENDOR_LIBRARY_NAME" = "nvidia";
    };

    environment.systemPackages = mkIf config.modules.hardware.graphics.nvidia (with pkgs; [
      cudaPackages.cudatoolkit
      libgbm
      egl-wayland
    ]);

    hardware.nvidia = mkIf config.modules.hardware.graphics.nvidia {
      modesetting.enable = true;
      videoAcceleration = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
    };

    # AMD configuration
    services.xserver.videoDrivers = mkIf config.modules.hardware.graphics.amd ["amdgpu"];
    
    environment.systemPackages = mkIf config.modules.hardware.graphics.amd (with pkgs; [
      rocm-opencl-icd
      rocm-opencl-runtime
    ]);

    # Intel configuration
    services.xserver.videoDrivers = mkIf config.modules.hardware.graphics.intel ["modesetting"];
    
    environment.systemPackages = mkIf config.modules.hardware.graphics.intel (with pkgs; [
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ]);
  };
} 