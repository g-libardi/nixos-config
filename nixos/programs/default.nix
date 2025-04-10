{ pkgs, ... }:
  #   let
  # # Function to recursively find all default.nix files under a given path
  # findDefaultNix = path:
  #   let
  #     # Read the directory entries
  #     entries = builtins.readDir path;
  #     # Process each entry
  #     processEntry = name: type:
  #       if type == "directory" then
  #         # Recurse into the directory
  #         findDefaultNix (path + "/${name}")
  #       else if type == "regular" && name == "default.nix" then
  #         # Add the path to the list if it's default.nix
  #         [ (path + "/${name}") ]
  #       else
  #         # Ignore other entries
  #         [];
  #   in
  #     # Concatenate all lists of paths found
  #     builtins.concatLists (builtins.attrValues (builtins.mapAttrs processEntry entries));
  #
  # # Find all default.nix files starting from ./myDir
  # defaultNixFiles = findDefaultNix ./.;
  #
  # # Import each found default.nix file
  # imports = builtins.map (p: import p) defaultNixFiles;

# in
{
    # inherit imports;
    imports = [
        ./nvim/default.nix
    ];

    # other programs
    # steam
    programs.steam = {
        enable = true;
        extest.enable = true;
        protontricks.enable = true;
        remotePlay.openFirewall = true;
    };

    environment.systemPackages = with pkgs; [
        zen-browser
        discord
        ticktick
    ];


    # Enable themeing for GTK and QT
    qt.style = "adwaita-dark";
    xdg.portal = {
        enable = true;
        wlr.enable = true;
        config.common.default = "*";
        extraPortals = with pkgs; [
            xdg-desktop-portal-wlr
            xdg-desktop-portal-gtk
        ];
    };
}
