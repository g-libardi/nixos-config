{ lib, ... }:

with lib;

{
  options = {
    # Host configuration options
    host = {
      type = mkOption {
        type = types.enum [ "desktop" "laptop" ];
        description = "Type of host system";
      };
      
      profiles = mkOption {
        type = types.listOf (types.enum [ "development" "gaming" "minimal" ]);
        default = [];
        description = "List of profiles to enable for this host";
      };
    };

    # Module configuration options
    modules = {
      # System modules
      system = {
        boot = {
          enable = mkEnableOption "boot configuration";
          secureboot = mkEnableOption "secure boot with lanzaboote";
        };
        
        networking = {
          enable = mkEnableOption "networking configuration";
          networkmanager = mkEnableOption "NetworkManager";
        };
        
        locale = {
          enable = mkEnableOption "locale configuration";
          timezone = mkOption {
            type = types.str;
            default = "America/Sao_Paulo";
            description = "System timezone";
          };
        };
        
        shell = {
          enable = mkEnableOption "shell configuration";
          zsh = mkEnableOption "Zsh shell with enhancements";
        };
        
        nix = {
          enable = mkEnableOption "Nix configuration and optimization";
          autoUpgrade = mkEnableOption "automatic system upgrades";
          garbageCollection = mkEnableOption "automatic garbage collection";
          flakePath = mkOption {
            type = types.str;
            default = "/home/libardi/nixos-config/.";
            description = "Path to the system configuration flake";
          };
        };
      };

      # Desktop environment modules
      desktop = {
        enable = mkEnableOption "desktop environment support";
        
        hyprland = {
          enable = mkEnableOption "Hyprland desktop environment";
        };
        
        qtile = {
          enable = mkEnableOption "Qtile desktop environment";
        };
        
        wayland = {
          enable = mkEnableOption "Wayland support";
        };
        
        x11 = {
          enable = mkEnableOption "X11 support";
        };
      };

      # Hardware modules
      hardware = {
        graphics = {
          enable = mkEnableOption "graphics configuration";
          nvidia = mkEnableOption "NVIDIA graphics drivers";
          amd = mkEnableOption "AMD graphics drivers";
          intel = mkEnableOption "Intel graphics drivers";
        };
        
        audio = {
          enable = mkEnableOption "audio configuration";
          pipewire = mkEnableOption "PipeWire audio system";
          pulseaudio = mkEnableOption "PulseAudio (legacy)";
        };
        
        bluetooth = {
          enable = mkEnableOption "Bluetooth support";
          powerOnBoot = mkEnableOption "Bluetooth power on boot";
        };
        
        input = {
          enable = mkEnableOption "input device configuration";
          touchpad = mkEnableOption "touchpad support";
          gamepad = mkEnableOption "gamepad support";
        };
      };

      # Service modules
      services = {
        printing = mkEnableOption "printing services (CUPS)";
        virtualization = mkEnableOption "virtualization services";
        docker = mkEnableOption "Docker containerization";
        media = mkEnableOption "media services (MPRIS, etc.)";
      };

      # Program modules
      programs = {
        development = {
          enable = mkEnableOption "development tools and environment";
          languages = mkOption {
            type = types.listOf (types.enum [ "python" "rust" "go" "nodejs" "java" "c" ]);
            default = [];
            description = "Programming languages to enable support for";
          };
        };
        
        nvim = {
          enable = mkEnableOption "Neovim with custom configuration";
        };
        
        terminal = {
          enable = mkEnableOption "terminal configuration";
          kitty = mkEnableOption "Kitty terminal";
        };
      };

      # Security modules
      security = {
        firewall = {
          enable = mkEnableOption "firewall configuration";
          strictMode = mkEnableOption "strict firewall mode";
        };
        
        secureboot = {
          enable = mkEnableOption "secure boot configuration";
        };
      };

      # User modules
      users = {
        enable = mkEnableOption "user configuration";
        defaultUser = mkOption {
          type = types.str;
          default = "libardi";
          description = "Default user name";
        };
      };
    };
  };
} 