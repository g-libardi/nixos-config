{ config, lib, ... }:

with lib;

{
  imports = [
    ../lib/options.nix
    ./development.nix
    ./gaming.nix
    ./minimal.nix
  ];

  config = {
    # Apply profiles based on host configuration
    # Profiles are automatically enabled when listed in host.profiles
  };
} 