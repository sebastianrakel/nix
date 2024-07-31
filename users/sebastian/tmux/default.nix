{config, pkgs, unstable, ... }:
{
  programs.tmux = {
    enable = true;
    keyMode = "emacs";
    mouse = true;
    clock24 = true;
    extraConfig = ''
      set -g set-titles on
      set -g set-titles-string "tmux:#{=/8/..:session_name}:#{window_index} [#{=/8/..:window_name};#{pane_title}]"
      source-file ${config.home.homeDirectory}/.config/tmux/theme.conf
      bind c new-window -c "#{pane_current_path}"
      bind f run-shell -b "tmux list-windows -F \"##I:##W\" | fzf-tmux | cut -d \":\" -f 1 | xargs tmux select-window -t"
      bind r source-file ~/.config/tmux/tmux.conf   
    '';
  };

  home.file.".config/tmux/theme.conf".source = config.themes.base16.tmux;
}
