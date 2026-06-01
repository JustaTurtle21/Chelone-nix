{pkgs, ...}:
{
  programs.rofi = {
    enable = true;
    modes = [
      "drun"
      "emoji"
    ];
    plugins = with pkgs; [
      rofi-calc
    ];
  };
}
