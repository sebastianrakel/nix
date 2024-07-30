{lib, pkgs, config, ...}:
{
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };
}
