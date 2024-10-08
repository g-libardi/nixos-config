{ pkgs, config, g, ... }:
let
    # Define the file content
    myConfig = pkgs.writeText "myapp-config" ''
    # Configuration file content goes here
    setting1=value1
    setting2=value2
    '';
in
{
    environment.systemPackages = [
        pkgs.cowsay
    ];

    environment.home.file = {
        "libardi/nixostesting".source = myConfig;
    };
}
