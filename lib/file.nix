{ lib, pkgs, config, ... }:
let
  # Sanitizes path names for the Nix store and appends a hash to prevent collisions.
  storeFileName = path:
    let
      pathStr = toString path;
      base = baseNameOf pathStr;  # Fixed: Use baseNameOf directly

      # List of allowed characters
      allowedChars = [ "+" "." "_" "?" "=" "-" ]
        ++ lib.strings.lowerChars
        ++ lib.strings.upperChars
        ++ (lib.strings.stringToCharacters "0123456789");

      sanitizedBase = lib.pipe base [
        (lib.strings.stringToCharacters)
        (lib.filter (c: lib.elem c allowedChars))
        lib.concatStrings
        lib.strings.sanitizeDerivationName  # Also fixed: lib.strings.sanitizeDerivationName
      ];

      hash = builtins.substring 0 20 (builtins.hashString "sha256" pathStr);
    in
      "nixos_linked_file_${hash}_${sanitizedBase}";

  # Creates a symlink in the store pointing to an out-of-store file.
  mkOutOfStoreSymlink = path:
    pkgs.runCommand (storeFileName path) {} ''
      ln -sn ${lib.escapeShellArg (toString path)} $out
    '';
in
  {
  ##### 1) Define our top-level module option: "file"
  options.file = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule ({ name, config, ... }: {
      options = {
        text = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "Optional text content for the file at ${name}.";
        };
        source = lib.mkOption {
          type = lib.types.nullOr lib.types.path;
          default = null;
          description = "Optional source file to symlink to ${name}.";
        };
      };
    }));
    default = {};
    description = "Attribute set of files to manage, keyed by absolute path.";
  };

  config.assertions = 
  let
    declaredFiles = builtins.attrNames config.file;
    
    # Only allow absolute paths
    invalidPaths = lib.filter (path: ! lib.hasPrefix "/" path) declaredFiles;

    # Not possible to declare source and text at the same file
    invalidCfg = lib.filter (path: let cfg = config.file.${path}; in cfg.source != null && cfg.text != null) declaredFiles;
  in
    [
      { assertion = builtins.length invalidPaths == 0; message = "Paths should be absolute: ${lib.concatStringsSep ", " invalidPaths}"; }
      { assertion = builtins.length invalidCfg == 0; message = "Cannot declare both source and text for the same file: ${lib.concatStringsSep ", " invalidCfg}"; }
    ];


  ##### 2) Implementation: activation script to manage files
  config = {
    system.activationScripts.fileManagement = {
      text = let
        declaredFiles = builtins.attrNames config.file;
      in ''
        set -euo pipefail

        STATE_DIR="/var/lib/declarativeFiles"
        mkdir -p "$STATE_DIR"

        NEW_DECLARED="$STATE_DIR/new-declared"
        OLD_DECLARED="$STATE_DIR/old-declared"

        : > "$NEW_DECLARED"

        # Gather all declared file paths
        ${lib.concatMapStrings (filePath: ''
          echo "${lib.escapeShellArg filePath}" >> "$NEW_DECLARED"
        '') declaredFiles}

        # Compare with previously declared files, remove those no longer declared
        if [ -f "$OLD_DECLARED" ]; then
          while IFS= read -r oldPath; do
            if ! grep -Fxq "$oldPath" "$NEW_DECLARED"; then
              if [ -L "$oldPath" ] || [ -f "$oldPath" ]; then
                rm -fv "$oldPath"
              fi
            fi
          done < "$OLD_DECLARED"
        fi

        # Create or update declared files
        ${lib.concatMapStrings (filePath:
          let
            cfg = config.file.${filePath};
            sourcePath = cfg.source;
            textContent = cfg.text;
          in ''
            mkdir -p "$(dirname "${lib.escapeShellArg filePath}")"
            ${lib.optionalString (sourcePath != null) ''
              ln -sfn "${mkOutOfStoreSymlink sourcePath}" "${lib.escapeShellArg filePath}"
            ''}
            ${lib.optionalString (textContent != null) ''
              printf '%s' ${lib.escapeShellArg textContent} > "${lib.escapeShellArg filePath}"
            ''}
          '') declaredFiles}

        # Persist the new declarations
        mv -f "$NEW_DECLARED" "$OLD_DECLARED"
      '';
      deps = [ "etc" ]; # Adjust based on your target directory structure
    };
  };
}
