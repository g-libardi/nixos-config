{ home, config, ... }:
let
  thisDir = "${config.home.homeDirectory}/nixos-config/home-manager";
  dotfilesSource = "${thisDir}/config";
  dotfilesTarget = ".config";
  dotfileNames = builtins.attrNames (builtins.readDir ./config);
in
{
  home.file = builtins.listToAttrs (map (dotname: {
    name = "${dotfilesTarget}/${dotname}"; 
    
    value = {
      source = config.lib.file.mkOutOfStoreSymlink "${dotfilesSource}/${dotname}";
      recursive = true;
    };
  }) dotfileNames);
}
#
# 