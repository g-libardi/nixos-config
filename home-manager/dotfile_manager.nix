{}:
let
  dotfilesSource = ./config;
  dotfilesTarget = ~/.config;
  dotfiles = builtins.readDir dotfilesSource;
  dirs = builtins.filter (name: builtins.pathExists (dotfilesSource + "/" + name) && builtins.isDir (dotfilesSource + "/" + name)) (builtins.attrNames dotfiles);
in
  dirs