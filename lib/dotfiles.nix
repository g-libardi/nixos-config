{ lib, pkgs }:
rec {
  # Util thaat uses "file" to create a symlink to a home file in the home directory with relative paths
  homeLink = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule ({ name, config, ... }: {
      options = {
        source = lib.mkOption {
          type = lib.types.path;
          description = "Source file to symlink to ${name}.";
        };
      };
    }));
  };

  # file =
  #   let
  #     declaredFiles = builtins.attrNames config.homeLink;
  #     # Concatenate declared files to home directory
  #     concatFiles = lib.concatStringsSep " " (builtins.map (name: "${config.homeLink.${name}.source} /home/libardi/${name}") declaredFiles);
  #   in 
}
