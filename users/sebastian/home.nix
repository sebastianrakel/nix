{ config, pkgs, ... }:
{
  home.username = "sebastian";
  home.homeDirectory = "/home/sebastian/";

  programs.zsh.enable = true;

  programs.git = {
    enable = true;
    userName = "Sebastian Rakel";
    userEmail = "sebastian@devunit.eu";
  };

  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
  };

  home.file = {
    ".emacs.d/init.el".source = ./emacs/init.el;
    ".emacs.d/early-init.el".source = ./emacs/early-init.el;
  };

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
