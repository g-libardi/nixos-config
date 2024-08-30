{ home }:
let
  thisDir = "${builtins.getEnv "HOME"}/nixos-config/home-manager";
  dotfilesSource = thisDir + "/config";
  dotfilesTarget = ~/.config;
  dotfileNames = builtins.readDir dotfilesSource;
  # dotfiles = builtins.map (name: 
  # ("${thisDir}/${name}")
  
  # ) 
  # (builtins.attrNames dotfileNames);
in
map (name: {
  home.file."${dotfilesTarget}/${name}" = {
    source = config.lib.file.mkOutOfStoreSymlink "${thisDir}/${name}";
    recursive = true;
  }
}) dotfileNames
  