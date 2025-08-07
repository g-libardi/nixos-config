{ config, pkgs, lib, ... }:

with lib;

{
  config = mkIf config.modules.security.firewall.enable {
    # SSH configuration with security settings
    services.openssh = {
      enable = true;
      settings = {
        GatewayPorts = "yes";
        PasswordAuthentication = false;
        PubkeyAuthentication = true;
      };

      extraConfig = ''
        # Special user for Foundry tunnel
        Match User foundrytunnel
          PasswordAuthentication yes
          AllowTcpForwarding yes
          PermitTTY no
          X11Forwarding no
          AllowAgentForwarding no
          ForceCommand /usr/bin/env echo 'Este usuário só pode fazer encaminhamento de porta. Conexão encerrada.'
      '';
    };

    # Foundry proxy user
    users.users.foundryproxy = {
      isSystemUser = false;
      isNormalUser = true;
      description = "User for Foundry proxy";
      group = "nogroup";
      home = "/var/empty";
      createHome = false;
      shell = "${pkgs.shadow}/bin/nologin";
    };

    # Firewall configuration
    networking.firewall = {
      enable = true;
      allowedTCPPorts = if config.modules.security.firewall.strictMode 
        then [ 22 ]  # Only SSH in strict mode
        else [ 8000 3000 25565 22 30000 ];
      allowedUDPPorts = if config.modules.security.firewall.strictMode 
        then [ ]  # No UDP in strict mode
        else [ 25565 ];
      trustedInterfaces = [ "eno1" "lo" "wlp4s0" ];
      allowPing = !config.modules.security.firewall.strictMode;
    };

    # Enable NFS server when not in strict mode
    services.nfs.server.enable = mkIf (!config.modules.security.firewall.strictMode) false;
  };
} 