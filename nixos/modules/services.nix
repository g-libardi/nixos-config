{ config, pkgs, ... }:

{

  # network manager
  networking.networkmanager.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # bluetooth
  # hardware.bluetooth.enable = true;
  # hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        experimental = true;  # show battery level

        # For controller
        Privacy = "device";
        JustWorksRepairing = "always";
        Class = "0x000100";
        FastConnectable = "true";
      };
    };
  };
  hardware.xpadneo.enable = true;

  # Enable MPRIS support for media players.
  services.playerctld.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
    wireplumber.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
  environment.systemPackages = with pkgs; [
    pavucontrol
    pulseaudio
    helvum
  ];

  # Reaktime audio helper
  musnix.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;




  # WARN: TEMPORATY!
  # Virtual cam settings: see https://wiki.nixos.org/wiki/OBS_Studio#Using_the_Virtual_Camera
  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';
  security.polkit.enable = true;

  # Install OBS Studio with droidcam-obs
  users.users.libardi = {
    packages = with pkgs; [
      # ...
      (wrapOBS {
        plugins = with obs-studio-plugins; [
          droidcam-obs
          easyeffects
        ];
      })
      # ...
    ];
  };
}
