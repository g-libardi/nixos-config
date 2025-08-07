{ config, lib, ... }:

with lib;

{
  imports = [
    ../../lib/options.nix
    ./development.nix
    ./nvim.nix
    ./terminal.nix
  ];

  config = mkIf (config.modules.programs.development.enable ||
                 config.modules.programs.nvim.enable ||
                 config.modules.programs.terminal.enable) {
    
    # Auto-enable common programs
    modules.programs = {
      terminal.enable = mkDefault true;
    };
  };
} 