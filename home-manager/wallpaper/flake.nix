{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };

  outputs = { self, nixpkgs }: 
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.packages.${system};
    in {
      packages.${system}.default = pkgs.stdenv.mkDerivation rec {
        name = "wallpaper-engine";
        version = "1.0.0";
        src = pkgs.fetchFromGitHub {
          owner = "Almamu";
          repo = "linux-wallpaperengine";
          rev = "main";
          sha256 = "";
        };

        nativeBuildInputs = with pkgs; [
          cmake
          make
        ];

        buildInputs = with pkgs; [
          libxrandr
          freeimage
          libxinerama
          libxcursor
          libxi
          libgl
          glew
          freeglut
          sdl2
          lz4
          ffmpeg
          libxxf86vm
          glm
          glfw3
          mpv
          libmpv
          pulseaudio
        ];

        buildPhase = ''
          mkdir build
          cd build
          cmake ..
          make
        '';
      };
    };
}