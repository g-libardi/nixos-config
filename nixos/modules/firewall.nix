{ config, pkgs, ... }:

{
    networking.firewall = {
        enable = true;
        allowedTCPPorts = [ 8000 3000 ];
        allowedUDPPorts = [ ]; # Add UDP ports if needed
        trustedInterfaces = [ "eno1" ]; # Replace with your actual network interfaces
    };
}
