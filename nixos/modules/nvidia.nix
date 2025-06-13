{ pkgs, config, ...}:

{
    # Enable OpenGL
    hardware.graphics = {
        enable = true;
        enable32Bit = true;
    };


    # Load nvidia driver for Xorg and Wayland
    services.xserver.videoDrivers = ["nvidia"];

    # Disable hardware cursor for hyprland
    environment.variables = {
        "WLR_NO_HARDWARE_CURSORS" = "1";
        "GBM_BACKEND" = "nvidia-drm";
        "__GLX_VENDOR_LIBRARY_NAME" = "nvidia";
    };

    # Enable CUDA support
    environment.systemPackages = with pkgs; [
        cudaPackages.cudatoolkit
        libgbm
        egl-wayland
    ];

    hardware.nvidia = {
        # Modesetting is required.
        modesetting.enable = true;

        # Enable Video Acceleration API (VAAPI) support
        videoAcceleration = true;

        # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
        # Enable this if you have graphical corruption issues or application crashes after waking
        # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
        # of just the bare essentials.
        powerManagement.enable = false;

        # Fine-grained power management. Turns off GPU when not in use.
        # Experimental and only works on modern Nvidia GPUs (Turing or newer).
        powerManagement.finegrained = false;

        # Use the NVidia open source kernel module (not to be confused with the
        # independent third-party "nouveau" open source driver).
        # Support is limited to the Turing and later architectures. Full list of 
        # supported GPUs is at: 
        # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
        # Only available from driver 515.43.04+
        # Currently alpha-quality/buggy, so false is currently the recommended setting.
        open = false;

        # Enable the Nvidia settings menu,
        # accessible via `nvidia-settings`.
        nvidiaSettings = true;

        # Driver version to use.
        package = config.boot.kernelPackages.nvidiaPackages.latest;
    };
}
