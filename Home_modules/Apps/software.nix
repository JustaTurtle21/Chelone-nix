{ inputs, pkgs, settings, ... }: let
  # Bring in the unstable channel
  unstable = import inputs.nixpkgs-unstable {
    inherit (pkgs) system;
    config.allowUnfree = true;
  };
in{
  home.packages = with pkgs; [
    # Use the prefix 'unstable.' for unstable packages
    vim
    bottles
    unstable.qbittorrent
    pureref
    flameshot
    libnvme
    libreoffice-fresh
    affinity-v3
    easyeffects
    unstable.davinci-resolve
    handbrake
    koodo-reader
    rapidraw
    darktable
    lutris
    inkscape
    gamemode
    equibop
    # cough cough piracy stuff
    inputs.sls-steam.packages.${pkgs.system}.wrapped
  ];
}
