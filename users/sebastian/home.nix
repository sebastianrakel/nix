{ config, pkgs, unstable, ... }:
{
  home.username = "sebastian";

  programs.git = {
    enable = true;
    userName = "Sebastian Rakel";
    userEmail = "sebastian@devunit.eu";
  };

  programs.emacs = {
    enable = true;
    package = unstable.emacs;
  };

  home.file = {
    ".emacs.d/init.el".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nix/users/sebastian/emacs/init.el";
    ".emacs.d/early-init.el".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nix/users/sebastian/emacs/early-init.el";
  };

  home.packages = with pkgs; [
    fzf
    rink
    monaspace
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initExtra = ''
      fpath+=(${pkgs.pure-prompt}/share/zsh/site-functions)
      autoload -U promptinit; promptinit
      prompt pure
    '';

    profileExtra = ''
      if [ -z $DISPLAY ] && [ $XDG_VTNR -eq 1 ]; then
        exec startx
      fi
    '';

    shellAliases = {
      ll = "ls -l";
      nupdate = "cd ~/.nix && sudo nixos-rebuild switch --upgrade --flake .#$(hostname)";
      dd = "dd status=progress";
      ddd = "dd oflag=direct status=progress";
      ddf = "dd conv=fsynci status=progress";
      ip = "ip -c";
      ips = "ip -br a";
      g = "git";
      hc = "herbstclient";
      em = "emacsclient -n";
      tmux = "tmux -2";
      "_" = "sudo ";
      sc = "systemctl";
    };

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
  };

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
