{ pkgs, config, ...}:
{
    environment.systemPackages = [ pkgs.minecraft ];
}
