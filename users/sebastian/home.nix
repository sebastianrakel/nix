{ config, pkgs, unstable, nur, ... }:
{
  home.username = "sebastian";
  xsession.enable = true;

  home.packages = with pkgs; [
    fzf
    rink
    monaspace
    nur.fb-client
    nur.workspace-switcher
  ];

  home.sessionVariables = {
      BROWSER                     = "firefox";
      VAGRANT_DEFAULT_PROVIDER    = "libvirt";
      QT_AUTO_SCREEN_SCALE_FACTOR = 0;
  };

  imports = [
    ./zsh
    ./alacritty
    ./rofi
    ./herbstluftwm
    ./emacs
    ./git
    ./eww
    ./modules/development/go
    ./modules/development/embedded
  ];
  
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
