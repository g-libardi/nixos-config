{ config, lib, pkgs, ... }:

with lib;

{
  config = mkIf (builtins.elem "gaming" config.host.profiles) {
    # Enable gamepad support
    modules.hardware.input.gamepad = true;
    
    # Gaming packages
    environment.systemPackages = with pkgs; [
      # Steam and gaming platforms
      steam
      lutris
      heroic
      
      # Game launchers
      bottles
      
      # Performance monitoring
      mangohud
      gamemode
      
      # Communication
      discord
      
      # Game development
      godot_4
      
      # Emulation
      # retroarch
      # dolphin-emu
    ];
    
    # Enable Steam
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession.enable = true;
    };
    
    # Enable GameMode for performance optimization
    programs.gamemode.enable = true;
    
    # Hardware optimizations for gaming
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
    
    # Audio optimizations
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
} 