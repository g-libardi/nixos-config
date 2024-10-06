{
  description = "Flake for wallpaper-engine-kde-plugin";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux"; # Adjust this to your system if necessary
      pkgs = import nixpkgs { inherit system; };
      lib = pkgs.lib;
      inherit (pkgs) mkKdeDerivation;
    in
    {
      packages.${system} = rec {
        wallpaper-engine-kde-plugin = mkKdeDerivation {
          pname = "wallpaper-engine-kde-plugin";
          version = "0.5.5-unstable-2024-06-16";

          src = pkgs.fetchFromGitHub {
            owner = "catsout";
            repo = "wallpaper-engine-kde-plugin";
            rev = "1e604105c586c7938c5b2c19e3dc8677b2eb4bb4";
            sha256 = "bKGQxyS8gUi+37lODLVHphMoQwLKZt/hpSjR5MN+5GA=";
            fetchSubmodules = true;
          };

          patches = [ ./nix-plugin.patch ];

          nativeBuildInputs = [
            pkgs.kpackage
            pkgs.pkg-config
          ];

          buildInputs = [
            pkgs.extra-cmake-modules
            pkgs.libplasma
            pkgs.lz4
            pkgs.mpv
          ];

          cmakeFlags = [
            "-DQML2_CMAKE_PATH=${lib.makeSearchPath "lib/qt-6/qml" [
              pkgs.qtmultimedia
              pkgs.qtwebchannel
              pkgs.qtwebengine
              pkgs.qtwebsockets
            ]}"
            "-DQt6_DIR=${pkgs.qtbase}/lib/cmake/Qt6"
            "-DUSE_PLASMAPKG=ON"
          ];

          postInstall = let
            py3-ws = pkgs.python3.withPackages (ps: with ps; [ ps.websockets ]);
          in ''
            cd ../plugin
            PATH=${py3-ws}/bin:$PATH patchShebangs --build ./contents/pyext.py
            substituteInPlace ./contents/ui/Pyext.qml --replace NIX_STORE_PACKAGE_PATH ${placeholder "out"}
            kpackagetool6 -i ./ -p $out/share/plasma/wallpapers/
          '';

          meta = with lib; {
            description = "KDE wallpaper plugin integrating Wallpaper Engine";
            homepage = "https://github.com/catsout/wallpaper-engine-kde-plugin";
            license = licenses.gpl2Only;
            maintainers = with pkgs.maintainers; [ macronova ];
          };
        };
      };

      defaultPackage.${system} = self.packages.${system}.wallpaper-engine-kde-plugin;
    };
}
