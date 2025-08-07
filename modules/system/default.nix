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

  config = mkIf (config.modules.system.boot.enable ||
                 config.modules.system.networking.enable ||
                 config.modules.system.locale.enable ||
                 config.modules.system.shell.enable ||
                 config.modules.system.nix.enable) {
    
    # Enable all system modules by default when any system module is enabled
    modules.system = {
      boot.enable = mkDefault true;
      networking.enable = mkDefault true;
      locale.enable = mkDefault true;
      shell.enable = mkDefault true;
      nix.enable = mkDefault true;
    };
  };
} 