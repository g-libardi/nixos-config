{ pkgs, config, ... }:

{
    environment.systemPackages = with pkgs; [
        rustup
        uv
        deno
        gcc
    ];
}
