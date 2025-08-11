{ config, lib, ... }:

with lib;

{
  imports = [
    ../../lib/options.nix
    ./development.nix
    ./nvim.nix
    ./terminal.nix
  ];

  # Set programs module defaults
  config.modules.programs = {
    terminal.enable = mkDefault true;
  };
} 