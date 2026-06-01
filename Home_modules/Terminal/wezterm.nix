{...}:
{
  programs.wezterm = {
    enable = true;
    extraConfig = "
    local wezterm = require 'wezterm'

    local config = wezterm.config_builder()

    config.font =
      wezterm.font('JetBrains Mono', { weight = 'Medium', italic = true })

    config.font_size = 10

    config.hide_tab_bar_if_only_one_tab = true

    return config
    ";
  };
}
