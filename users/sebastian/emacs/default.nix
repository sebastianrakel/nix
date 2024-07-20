{ config, pkgs, unstable, ... }:
{
  home.file."emacs_theme" = {
    source = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/tinted-theming/base16-emacs/main/build/base16-harmonic16-light-theme.el";
      sha256 = "1hdf93pdc260mz44c25akjrkqqjcah2bj3kraxm74sxrk7p8snw5";
    };
    target = ".emacs.d/theme.el";
  };
  
  programs.emacs = {
    enable = true;
    package = unstable.emacs;
  };

  home.file = {
    ".emacs.d/init.el".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nix/users/sebastian/emacs/init.el";
    ".emacs.d/early-init.el".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nix/users/sebastian/emacs/early-init.el";
  };
}
