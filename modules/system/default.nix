{ config, lib, ... }:

with lib;

{
  imports = [
    ../../lib/options.nix
    ./boot.nix
    ./networking.nix
    ./locale.nix
    ./shell.nix
    ./nix.nix
  ];

  # Set system module defaults outside of conditional config
  config.modules.system = {
    boot.enable = mkDefault true;
    networking.enable = mkDefault true;
    locale.enable = mkDefault true;
    shell.enable = mkDefault true;
    nix.enable = mkDefault true;
  };
} 