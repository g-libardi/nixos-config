{ config, lib, pkgs, ... }:

with lib;

{
  config = mkIf (builtins.elem "development" config.host.profiles) {
    # Enable development programs
    modules.programs.development = {
      enable = true;
      languages = [ "rust" "python" "nodejs" "c" "go" ];
    };
    
    # Enable Docker for containerized development
    modules.services.docker = true;
    
    # Enable virtualization for testing
    modules.services.virtualization = true;
    
    # Additional development packages
    environment.systemPackages = with pkgs; [
      # Version control
      git-lfs
      gitui
      
      # Networking tools
      curl
      wget
      httpie
      
      # Database tools
      sqlite
      postgresql
      
      # Container tools
      dive
      lazydocker
      
      # System tools
      htop
      btop
      tree
      jq
      yq
      
      # Text processing
      ripgrep
      fd
      sd
      bat
      eza
      
      # Archive tools
      unzip
      p7zip
      
      # Development utilities
      just
      watchexec
      tokei
    ];
    
    # Git configuration
    programs.git = {
      enable = true;
      config = {
        init.defaultBranch = "main";
        pull.rebase = true;
        push.autoSetupRemote = true;
      };
    };
    
    # Enable direnv for project-specific environments
    programs.direnv.enable = true;
  };
} 