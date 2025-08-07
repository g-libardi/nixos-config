{ config, lib, ... }:

with lib;

{
  imports = [
    ../../lib/options.nix
    ./printing.nix
    ./virtualization.nix
    ./media.nix
  ];

  config = mkIf (config.modules.services.printing ||
                 config.modules.services.virtualization ||
                 config.modules.services.docker ||
                 config.modules.services.media) {
    # Auto-enable common services
    modules.services = {
      media = mkDefault true;
    };
  };
} 