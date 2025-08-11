{ config, pkgs, lib, ... }:

with lib;

{
  config = mkMerge [
    # Set defaults
    {
      modules.programs.terminal.kitty = mkDefault true;
    }
    
    # Conditional configuration
    (mkIf config.modules.programs.terminal.enable {
      # Enable kitty terminal by default
      environment.systemPackages = mkIf config.modules.programs.terminal.kitty (with pkgs; [
        kitty
      ]);
    })
  ];
} 