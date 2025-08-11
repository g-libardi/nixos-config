{ config, pkgs, lib, ... }:

with lib;

{
  config = mkMerge [
    # Set defaults
    {
      modules.system.shell.zsh = mkDefault true;
    }
    
    # Conditional configuration
    (mkIf config.modules.system.shell.enable {
      # Default shell with auto-completion and syntax highlighting
      programs.zsh = mkIf config.modules.system.shell.zsh {
        enable = true;
        autosuggestions.enable = true;
        syntaxHighlighting.enable = true;
      };

      environment.systemPackages = mkIf config.modules.system.shell.zsh [
        pkgs.zplug
        pkgs.exfatprogs  # enable exFAT support
      ];

      environment.shells = mkIf config.modules.system.shell.zsh (with pkgs; [ zsh ]);
      users.defaultUserShell = mkIf config.modules.system.shell.zsh pkgs.zsh;
    })
  ];
} 