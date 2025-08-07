{ config, lib, ... }:

with lib;

{
  config = mkMerge [
    (mkIf config.modules.services.virtualization {
      # Enable common virtualization features
      virtualisation.libvirtd.enable = true;
      programs.virt-manager.enable = true;
    })

    (mkIf config.modules.services.docker {
      # Enable Docker
      virtualisation.docker.enable = true;
      virtualisation.docker.rootless = {
        enable = true;
        setSocketVariable = true;
      };
      
      # Add user to docker group
      users.users.${config.modules.users.defaultUser}.extraGroups = [ "docker" ];
    })
  ];
} 