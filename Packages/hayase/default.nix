{
  lib,
  pkgs,
  ...
}:
pkgs.appimageTools.wrapType2 rec {
  pname = "hayase";
  version = "6.4.60";

  src = pkgs.fetchurl {
    url = "https://api.hayase.watch/files/linux-hayase-${version}-linux.AppImage";
    hash = "sha256-A9JOd3JqYQ+Og0WDQESg1ABcaSYKsUu+spM0y58O4nM=";
  };

  # This ensures makeWrapper is available in the build environment
  nativeBuildInputs = [ pkgs.makeWrapper ];

  extraPkgs = pkgs: with pkgs; [
    libsecret
    nss
    atk
  ];

  extraInstallCommands = let
    contents = pkgs.appimageTools.extractType2 { inherit pname version src; };
  in ''
    # Install desktop files and icons
    install -m 444 -D ${contents}/${pname}.desktop $out/share/applications/${pname}.desktop
    install -m 444 -D ${contents}/usr/share/icons/hicolor/512x512/apps/${pname}.png $out/share/icons/hicolor/512x512/apps/${pname}.png

    # Fix the Exec path
    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace-fail 'Exec=AppRun' 'Exec=${pname}'

    # Wrap the binary
    wrapProgram $out/bin/${pname} \
      --add-flags "--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations"
  '';

  meta = with lib; {
    description = "Hayase - Torrent streaming made simple";
    homepage = "https://hayase.watch";
    license = licenses.bsl11;
    mainProgram = "hayase";
    platforms = [ "x86_64-linux" ];
  };
}
