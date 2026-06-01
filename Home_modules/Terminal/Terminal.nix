{config, pkgs, ...}:
{
  imports = [
    ./git.nix
    ./bash.nix
    ./term_soft.nix
    ./wezterm.nix
  ];
}
