{config, pkgs, ...}:
{
  programs.git = {
    enable = true;
    settings = {
      user.name = "justaturtle";
      user.email = "turtlemail@tmail.com";
      extraConfig = {
        init.defaultBranch = "main";
      };
    };
  };
}
