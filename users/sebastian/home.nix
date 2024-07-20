{ config, pkgs, unstable, ... }:
{
  home.username = "sebastian";
  xsession.enable = true;
 
  home.packages = with pkgs; [
    fzf
    rink
    monaspace
  ];

  home.sessionVariables = {
      GOPATH                      = "${config.home.homeDirectory}/.local/share/go";
      GOMODCACHE                  = "${config.home.homeDirectory}/.cache/go/mod";
      TERMINAL                    = "alacritty";
      BROWSER                     = "firefox";
      VAGRANT_DEFAULT_PROVIDER    = "libvirt";
      QT_AUTO_SCREEN_SCALE_FACTOR = 0;
      WINIT_HIDPI_FACTOR          = 1;
      WINIT_X11_SCALE_FACTOR      = 1;
  };

  imports = [
    ./alacritty
    ./herbstluftwm
    ./emacs
    ./zsh
    ./git
  ];
  
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
