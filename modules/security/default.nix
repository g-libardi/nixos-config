{ config, lib, ... }:

with lib;

{
  imports = [
    ../../lib/options.nix
    ./firewall.nix
    ./secure-boot.nix
  ];

  # Set security module defaults
  config.modules.security = {
    firewall.enable = mkDefault true;
  };
} 