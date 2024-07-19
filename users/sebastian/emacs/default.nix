{ config, pkgs, unstable, ... }:
{
  programs.emacs = {
    enable = true;
    package = unstable.emacs;
  };

  home.file = {
    ".emacs.d/init.el".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nix/users/sebastian/emacs/init.el";
    ".emacs.d/early-init.el".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nix/users/sebastian/emacs/early-init.el";
  };
}
