{ config, pkgs, unstable, ... }:
{ 
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initExtra = ''
      fpath+=(${pkgs.pure-prompt}/share/zsh/site-functions)
      autoload -U promptinit; promptinit
      prompt pure

      if [[ -e "${config.home.homeDirectory}/.zsh-private" ]]; then
        for config_file in ${config.home.homeDirectory}/.zsh-private/*.zsh; do source $config_file; done
      fi
    '';

    profileExtra = ''
      if [ -z $DISPLAY ] && [ $XDG_VTNR -eq 1 ]; then
        exec startx
      fi
    '';

    envExtra = ''
      if [ -f "${config.home.homeDirectory}/.zshenv.private" ]; then source "${config.home.homeDirectory}/.zshenv.private"; fi
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
      reload = "unset __HM_SESS_VARS_SOURCED; source ${config.home.homeDirectory}/.zshenv";
    };

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
  };
}
