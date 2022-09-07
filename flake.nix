{
  description = "Change how the screen should be extended when a new monitor is connected";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:numtide/flake-utils";
    };
  };

  outputs = { self, nixpkgs, flake-utils, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        # based on
        # https://discourse.nixos.org/t/flutter-run-d-linux-build-process-failed/16552/3
        dependencies = with pkgs; [
          # dependencies for flutter
          at-spi2-core.dev
          clang
          cmake
          dart
          dbus.dev
          flutter
          gtk3
          libdatrie
          libepoxy.dev
          libselinux
          libsepol
          libthai
          libxkbcommon
          ninja
          pcre
          pkg-config
          util-linux.dev
          xorg.libXdmcp
          xorg.libXtst
          cairo.dev
          # Dependencies for the flutter app
          brightnessctl
          pamixer
        ];
      in
        rec {
          defaultPackage = packages.rescreenapp;

          packages.rescreenapp = pkgs.stdenv.mkDerivation {
            name = "rescreenapp";
            pname = "rescreenapp";
            version = "1.0";
            src = ./.;
          
            buildInputs = dependencies;
            nativeBuildInputs = [ pkgs.makeWrapper ];
            dontConfigure = true;
            dontBuild = true;
            # buildPhase = ''
            #   mkdir -p $out/bin
            # '';
            installPhase = ''
              mkdir -p $out/bin
              cp -r $src/build/linux/x64/release/bundle/* $out/bin/
              wrapProgram $out/bin/rescreenapp \
                --set LD_LIBRARY_PATH ${pkgs.libepoxy}/lib
            '';
          };

          devShells.default = pkgs.mkShell {
            buildInputs = dependencies;
            # based on
            # https://discourse.nixos.org/t/flutter-run-d-linux-build-process-failed/16552/3#:~:text=The%20problem%20was%20that%20flutter%20does%20not%20use%20NixOS%20way%20to%20look%20for%20libraries%20during%20linking%20(most%20likely%20a%20bug%20in%20the%20package)%2C%20so%20LD_LIBRARY_PATH%2C%20which%20is%20unused%20on%20NixOS%20must%20be%20set
            shellHook = ''
              export LD_LIBRARY_PATH=${pkgs.libepoxy}/lib:$LD_LIBRARY_PATH
              export PUB_CACHE="./.cache/pub_cache"
            '';
          };
        }
      );
}
