{ config, pkgs, lib, ... }:

with lib;

{
  config = mkIf config.modules.hardware.audio.enable {
    # Realtime audio helper
    musnix.enable = true;
    
    # PipeWire configuration (default)
    services.pulseaudio.enable = mkIf (!config.modules.hardware.audio.pipewire) false;
    security.rtkit.enable = mkIf config.modules.hardware.audio.pipewire true;
    
    services.pipewire = mkIf config.modules.hardware.audio.pipewire {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };

    # PulseAudio configuration (legacy)
    services.pulseaudio = mkIf config.modules.hardware.audio.pulseaudio {
      enable = true;
      support32Bit = true;
    };

    environment.systemPackages = with pkgs; [
      pavucontrol
      pulseaudio
    ] ++ optionals config.modules.hardware.audio.pipewire [
      helvum
    ];

    # Default to PipeWire
    modules.hardware.audio.pipewire = mkDefault true;
  };
} 