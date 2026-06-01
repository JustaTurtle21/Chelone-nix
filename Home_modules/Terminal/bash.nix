{config, pkgs, ...}:
{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      switch = "sudo nixos-rebuild switch --flake /home/justaturtle/Chelone";
      houdini = "distrobox enter hate -- houdini";
      nuke = "distrobox enter hate -- /home/justaturtle/Nuke/Nuke17.0v1/Nuke17.0 --nc";
      pvz = "docker run --name pvzge -d -p 8080:80 gaozih/pvzge:latest";
      push = "git push github main";
    };
  };

}
