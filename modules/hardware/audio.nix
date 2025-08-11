{ config, pkgs, lib, ... }:

with lib;

{
  config = mkMerge [
    # Set defaults
    {
      modules.hardware.audio.pipewire = mkDefault true;
    }
    
    # Conditional configuration
    (mkIf config.modules.hardware.audio.enable {
    # Realtime audio helper
    musnix.enable = true;
    
    # Audio system configuration
    services.pulseaudio = {
      enable = config.modules.hardware.audio.pulseaudio;
      support32Bit = mkIf config.modules.hardware.audio.pulseaudio true;
    };
    
    security.rtkit.enable = mkIf config.modules.hardware.audio.pipewire true;
    
    services.pipewire = mkIf config.modules.hardware.audio.pipewire {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };

    environment.systemPackages = with pkgs; [
      pavucontrol
      pulseaudio
    ] ++ optionals config.modules.hardware.audio.pipewire [
      helvum
    ];
    })
  ];
} 