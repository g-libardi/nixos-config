{ config, lib, ... }:

with lib;

{
  config = mkIf config.modules.services.printing {
    # Enable CUPS to print documents
    services.printing.enable = true;
  };
} 