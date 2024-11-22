{ lib, pkgs }:
let
  # Helper function to sanitize the path for the Nix store
  storeFileName = path:
    let
      safeChars = [ "+" "." "_" "?" "=" ] ++ lib.strings.lowerChars ++ lib.strings.upperChars
        ++ lib.strings.stringToCharacters "0123456789";

      empties = l: lib.genList (x: "") (lib.length l);

      unsafeInName =
        lib.strings.stringToCharacters (lib.strings.replaceStrings safeChars (empties safeChars) path);

      safeName = lib.strings.replaceStrings unsafeInName (empties unsafeInName) path;
   in "nixos_" + safeName;


  # Main function to create the symlink
  mkOutOfStoreSymlink = path:
    let
      pathStr = toString path;
      name = storeFileName (lib.strings.baseNameOf pathStr);
    in
      pkgs.runCommand name {} ''
        ln -s ${lib.escapeShellArg pathStr} $out
      '';
in {
  lib = { inherit mkOutOfStoreSymlink; };
}
