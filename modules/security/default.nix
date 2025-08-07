{ config, lib, ... }:

with lib;

{
  imports = [
    ../../lib/options.nix
    ./firewall.nix
    ./secure-boot.nix
  ];

  config = mkIf (config.modules.security.firewall.enable ||
                 config.modules.security.secureboot.enable) {
    
    # Auto-enable common security modules
    modules.security = {
      firewall.enable = mkDefault true;
    };
  };
} 