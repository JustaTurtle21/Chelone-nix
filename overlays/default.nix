{inputs, pkgs, stdenv, ...}:
{
  nixpkgs.overlays = [
    inputs.nixpkgs-f2k.overlays.window-managers
    inputs.nixpkgs-f2k.overlays.compositors
    inputs.affinity-nix.overlays.default
    inputs.eden.overlays.default
    # Basically overrides the normal awm pkg with the f2k one (stole this from namishh)
    (final: prev:
      {
        awesome = inputs.nixpkgs-f2k.packages.${prev.stdenv.hostPlatform.system}.awesome-git;
      })
  ];
}
