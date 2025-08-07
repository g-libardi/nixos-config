{ config, pkgs, lib, ... }:

with lib;

{
  config = mkIf config.modules.services.media {
    # Enable MPRIS support for media players
    services.playerctld.enable = true;

    # Install OBS Studio with plugins for the default user
    users.users.${config.modules.users.defaultUser} = {
      packages = with pkgs; [
        (wrapOBS {
          plugins = with obs-studio-plugins; [
            droidcam-obs
            easyeffects
          ];
        })
      ];
    };
  };
} 