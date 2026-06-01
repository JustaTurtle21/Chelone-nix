{inputs, config, pkgs, ...}:
{
  # Pulls in themes
  home.file.".config/Equicord/themes/system24-everforest.theme.css".source = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/refact0r/system24/main/theme/flavors/system24-everforest.theme.css";
    sha256 = "sha256-DmODk27m8GiertFxVm5qnmxiMWHSo24AMdd7qwJULwQ=";
  };

  home.file.".config/Equicord/themes/system24-catppuccin-mocha.theme.css".source = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/refact0r/system24/main/theme/flavors/system24-catppuccin-mocha.theme.css";
    sha256 = "sha256-nHl+K7MTNt0d7NjxHBWhdX7OPoJ/+bxynaHw2I0/eNk=";
  };

  home.file.".config/Equicord/themes/system24-vencord.theme.css".source = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/refact0r/system24/main/theme/flavors/system24-vencord.theme.css";
    sha256 = "sha256-KQYFLlptx0+zy3PaEhH8NIcGelKXcf0tB45VzyqPP0E=";
  };

  home.file.".config/Equicord/themes/system24.theme.css".source = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/refact0r/system24/main/theme/system24.theme.css";
    sha256 = "sha256-cNrrCMC/GS8yi9kZW2cOXVmnCjffKOUjgO238pD2h7s=";
  };
}
