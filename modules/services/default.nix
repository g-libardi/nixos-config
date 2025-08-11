{ config, lib, ... }:

with lib;

{
  imports = [
    ../../lib/options.nix
    ./printing.nix
    ./virtualization.nix
    ./media.nix
  ];

  # Set services module defaults
  config.modules.services = {
    media = mkDefault true;
  };
} 