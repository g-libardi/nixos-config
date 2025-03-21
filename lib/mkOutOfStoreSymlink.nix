{ lib, pkgs, config, ... }:
let
  # Sanitizes path names for the Nix store.
  storeFileName = path:
    let
      allowedChars = [ "+" "." "_" "?" "=" ]
        ++ lib.strings.lowerChars
        ++ lib.strings.upperChars
        ++ (lib.strings.stringToCharacters "0123456789");

      removeAll = l: lib.genList (_: "") (lib.length l);
      toRemove = lib.strings.stringToCharacters
        (lib.strings.replaceStrings allowedChars (removeAll allowedChars) path);
      result = lib.strings.replaceStrings toRemove (removeAll toRemove) path;
    in
      "nixos_linked_file_" + result;

  # Creates a symlink in the store pointing to an out-of-store file.
  mkOutOfStoreSymlink = path:
    let
      pathStr = toString path;
      derivName = storeFileName (lib.strings.baseNameOf pathStr);
    in
      pkgs.runCommand derivName {} ''
        ln -s ${lib.escapeShellArg pathStr} $out
      '';
in
{
  ##### 1) Define our top-level module option: "file"
  #    This allows sub-options keyed by the path string.
  options.file = lib.mkNestedOptionModuleType (filePath: {
    options = {
      text = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Optional text content for the file at ${filePath}.";
      };
      source = lib.mkOption {
        type = lib.types.nullOr lib.types.path;
        default = null;
        description = "Optional source file to symlink to ${filePath}.";
      };
    };
  });

  ##### 2) Implementation: activation script to manage files
  config = {
    system.activationScripts.fileManagement = {
      text = ''
        set -eu

        STATE_DIR="/var/lib/declarativeFiles"
        mkdir -p "$STATE_DIR"

        NEW_DECLARED="$STATE_DIR/new-declared"
        OLD_DECLARED="$STATE_DIR/old-declared"

        : > "$NEW_DECLARED"

        # Gather all declared file paths
        ${lib.concatMapStrings (filePath:
          let
            opts = lib.attrByPath [ "file" filePath ] {} config;
            textContent = opts.text or null;
            sourcePath  = opts.source or null;
          in ''
            echo "${filePath}" >> "$NEW_DECLARED"
          ''
        ) (builtins.attrNames config.file)}

        # Compare with previously declared files, remove those no longer declared
        if [ -f "$OLD_DECLARED" ]; then
          while read -r oldPath; do
            if ! grep -qx "$oldPath" "$NEW_DECLARED"; then
              if [ -L "$oldPath" ] || [ -f "$oldPath" ]; then
                rm -f "$oldPath"
              fi
            fi
          done < "$OLD_DECLARED"
        fi

        # Create or update declared files
        ${lib.concatMapStrings (filePath:
          let
            opts = lib.attrByPath [ "file" filePath ] {} config;
            textContent = opts.text or null;
            sourcePath  = opts.source or null;
          in ''
            mkdir -p "$(dirname "${filePath}")"
            ${lib.optionalString (sourcePath != null) ''
              ln -sf ${mkOutOfStoreSymlink sourcePath} "${filePath}"
            ''}
            ${lib.optionalString (textContent != null) ''
              echo -n ${lib.escapeShellArg textContent} > "${filePath}"
            ''}
          ''
        ) (builtins.attrNames config.file)}

        # Persist the new declarations
        mv "$NEW_DECLARED" "$OLD_DECLARED"
      '';
      # No particular runtime dependencies needed, so empty list
      deps = [];
    };
  };
}

