{ config, pkgs, ... }:

{
    # Foundry proxy
    services.openssh = {
        enable = true;
        settings = {
            GatewayPorts = "yes";
        };

        extraConfig = ''
            # Seção de Match para o usuário específico
            # Match User foundryproxy
            #     # Permite apenas encaminhamento de porta. Desabilita outros recursos.
            #     AllowTcpForwarding yes # Necessário para -R
            #     PermitTTY no          # Desabilita terminal interativo (mesmo se o shell fosse /bin/bash)
            #     X11Forwarding no
            #     AllowAgentForwarding no
            #     ForceCommand /usr/bin/env echo 'Este usuário só pode fazer encaminhamento de porta. Conexão encerrada.'
            #     # A linha ForceCommand acima impede qualquer comando interativo após o login.
            #     # O túnel SSH (-R) é configurado ANTES do ForceCommand ser executado, então o túnel funciona.
            #     # Se o shell for nologin, ForceCommand pode ser redundante, mas é uma camada extra.

            # Se você quiser permitir login por senha APENAS para este usuário (NÃO RECOMENDADO se possível):
            Match User foundrytunnel
              PasswordAuthentication yes # PERMITE senha para este usuário
              AllowTcpForwarding yes
              PermitTTY no
              X11Forwarding no
              AllowAgentForwarding no
              ForceCommand /usr/bin/env echo 'Este usuário só pode fazer encaminhamento de porta. Conexão encerrada.'
            
            # E no bloco principal do sshd_config (fora do Match), você teria:
            PasswordAuthentication no # Desabilita senha para todos os outros

            # Certifique-se que a autenticação por chave pública está habilitada globalmente se for usar
            # PubkeyAuthentication yes
            '';
    };
    users.users.foundryproxy = {
        isSystemUser = false;
        isNormalUser = true;
        description = "User for Foundry proxy";
        group = "nogroup";
        home = "/var/empty";
        createHome = false;
        shell = "${pkgs.shadow}/bin/nologin";
    };

    # Firewall
    networking.firewall = {
        enable = true;
        allowedTCPPorts = [ 8000 3000 25565 22 30000 ];
        allowedUDPPorts = [ 25565 ]; # Add UDP ports if needed
        trustedInterfaces = [ "eno1" "lo" "wlp4s0" ]; # Replace with your actual network interfaces
        allowPing = true;

        # # Vagrant specific configuration
        # # Add firewall exception for VirtualBox provider 
        # extraCommands = ''
        # ip46tables -I INPUT 1 -i vboxnet+ -p tcp -m tcp --dport 2049 -j ACCEPT
        # '';

        # # Add firewall exception for libvirt provider when using NFSv4 
        # interfaces."virbr1" = {                                   
        #     allowedTCPPorts = [ 2049 ];                                               
        #     allowedUDPPorts = [ 2049 ];                                               
        # };

    };

    # virtualisation.virtualbox = {
    #     host.enable = true;
    #     host.enableKvm = true;
    #     host.addNetworkInterface = false;
    # };
    #
    # environment.systemPackages = with pkgs; [
    #     vagrant
    # ];
    #
    # # Minimal configuration for NFS support with Vagrant.
    # services.nfs.server.enable = true;
}
