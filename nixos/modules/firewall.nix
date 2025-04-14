{ config, pkgs, ... }:

{
    networking.firewall = {
        enable = true;
        allowedTCPPorts = [ 8000 3000 25565 ];
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
