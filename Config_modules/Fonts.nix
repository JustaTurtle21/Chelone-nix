{inputs, pkgs, ...}:
let
  unstable = import inputs.nixpkgs-unstable {
    inherit (pkgs) system;
    config.allowUnfree = true;
  };
in{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    unstable.google-fonts
  ];
}
