{ config, pkgs, unstable, ... }:
{
  programs.emacs = {
    enable = true;
    package = unstable.emacs;
  };

  # TODO: use variable for nix repo location
  home.file = {
    ".emacs.d/init.el".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nix/users/sebastian/emacs/init.el";
    ".emacs.d/early-init.el".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nix/users/sebastian/emacs/early-init.el";
    ".emacs.d/snippets" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nix/users/sebastian/emacs/snippets";
      recursive = true;
    };
    ".emacs.d/themes/base16-${config.themes.base16}-theme.el".source = config.themes.base16.emacs;
    ".emacs.d/selected-theme.el".text = ''
      (defvar current-theme 'base16-${config.themes.base16})
    '';
  };
}
