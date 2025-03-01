{ config, pkgs, ... }:

{
    networking.firewall = {
        enable = true;
        allowedTCPPorts = [ 8000 3000 25565 ];
        allowedUDPPorts = [ 25565 ]; # Add UDP ports if needed
        trustedInterfaces = [ "eno1" "lo" "wlp4s0" ]; # Replace with your actual network interfaces
        allowPing = true;
    };
}
