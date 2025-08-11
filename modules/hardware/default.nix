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

  # Set hardware module defaults
  config.modules.hardware = {
    audio.enable = mkDefault true;
    input.enable = mkDefault true;
  };
} 