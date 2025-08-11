{ config, pkgs, lib, ... }:

with lib;

{
  config = mkIf config.modules.hardware.graphics.enable {
    # Enable OpenGL/graphics
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    # Set video drivers based on enabled graphics options
    services.xserver.videoDrivers = 
      (optional config.modules.hardware.graphics.nvidia "nvidia") ++
      (optional config.modules.hardware.graphics.amd "amdgpu") ++
      (optional config.modules.hardware.graphics.intel "modesetting");
    
    # NVIDIA configuration
    environment.variables = mkIf config.modules.hardware.graphics.nvidia {
      "WLR_NO_HARDWARE_CURSORS" = "1";
      "GBM_BACKEND" = "nvidia-drm";
      "__GLX_VENDOR_LIBRARY_NAME" = "nvidia";
    };

    environment.systemPackages = 
      (optionals config.modules.hardware.graphics.nvidia (with pkgs; [
        cudaPackages.cudatoolkit
        libgbm
        egl-wayland
      ])) ++
      (optionals config.modules.hardware.graphics.amd (with pkgs; [
        rocm-opencl-icd
        rocm-opencl-runtime
      ])) ++
      (optionals config.modules.hardware.graphics.intel (with pkgs; [
        intel-media-driver
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
      ]));

    hardware.nvidia = mkIf config.modules.hardware.graphics.nvidia {
      modesetting.enable = true;
      videoAcceleration = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
    };
  };
} 