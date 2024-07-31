{ config, pkgs, unstable, ... }:
{ 
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "emacs";

    initExtra = ''
      fpath+=(${pkgs.pure-prompt}/share/zsh/site-functions)
      autoload -U promptinit; promptinit
      prompt pure

      # base16-shell
      base16_shell_theme_script=${config.themes.base16.shell}
      [ -n "$PS1" ] && [ -s $base16_shell_theme_script ] && . $base16_shell_theme_script
      unset base16_shell_theme_script

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

    # TODO: use nix location here to
    shellAliases = {
      ll = "ls -l";
      nupdate = "current=$(pwd); cd ~/.nix; sudo nixos-rebuild switch --upgrade --flake .#$(hostname); cd $current";
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
      reload = "unset __HM_SESS_VARS_SOURCED; source ${config.home.homeDirectory}/.zshenv";
      vm-destroy = "for vm in $(virsh list --name --state-running); do virsh destroy $vm; done";
    };

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
  };
}
