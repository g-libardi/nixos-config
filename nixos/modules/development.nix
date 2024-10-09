{ pkgs, config, ... }:

{
    environment.systemPackages = with pkgs; [
        rustup
        uv
        bun
        gcc
    ];
}
