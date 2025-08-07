{ config, lib, ... }:

with lib;

{
  imports = [
    ../../lib/options.nix
    ./graphics.nix
    ./audio.nix
    ./bluetooth.nix
    ./input.nix
  ];

  config = mkIf (config.modules.hardware.graphics.enable ||
                 config.modules.hardware.audio.enable ||
                 config.modules.hardware.bluetooth.enable ||
                 config.modules.hardware.input.enable) {
    
    # Auto-enable common hardware modules
    modules.hardware = {
      audio.enable = mkDefault true;
      input.enable = mkDefault true;
    };
  };
} 