{ config, pkgs, lib, ... }:

with lib;

{
  config = mkIf config.modules.programs.terminal.enable {
    # Enable kitty terminal by default
    environment.systemPackages = mkIf config.modules.programs.terminal.kitty (with pkgs; [
      kitty
    ]);

    # Default to kitty
    modules.programs.terminal.kitty = mkDefault true;
  };
} 