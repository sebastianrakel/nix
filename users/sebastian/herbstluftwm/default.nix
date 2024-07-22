{ config, pkgs, unstable, ... }:
{
   xsession.windowManager.herbstluftwm = {
    enable  = true;
    package = pkgs.herbstluftwm;
    keybinds = {
      Mod4-Shift-r       = "reload";
      Mod4-Shift-q       = "close";
      Mod4-t             = "spawn rofi -show theme -modes \"theme:\${HOME}/.config/rofi/modes/theme.sh\"";
      Mod4-Shift-E       = "spawn rofi -show pw -modes \"pw:\${HOME}/.config/rofi/modes/power.sh\"";
      Mod4-Return        = "spawn \${TERMINAL:-XTERM}";
      Mod4-d             = "spawn rofi -show combi -combi-modi drun,run -show-icons";
      Mod4-w             = "spawn rofi -show window -window-command 'herbstclient bring {window}'";
      Mod4-o             = "split right";
      Mod4-u             = "split bottom";
      Mod4-p             = "spawn workspace-switcher rofi";
      Mod4-Left          = "focus left";
      Mod4-Right         = "focus right";
      Mod4-Down          = "focus down";
      Mod4-Up            = "focus up";
      Mod4-Shift-Left    = "shift left";
      Mod4-Shift-Right   = "shift right";
      Mod4-Shift-Up      = "shift up";
      Mod4-Shift-Down    = "shift down";
      Mod4-Control-Left  = "resize left +0.02";
      Mod4-Control-Down  = "resize down +0.02";
      Mod4-Control-Up    = "resize up +0.02";
      Mod4-Control-Right = "resize right +0.02";
      Mod4-space         = "or , and . compare tags.focus.curframe_wcount = 2 . cycle_layout +1 vertical horizontal max vertical grid , cycle_layout +1";
      Mod4-c             = "cycle";
      Mod4-f             = "fullscreen toggle";
      Mod4-r             = "remove";
      Mod4-1             = "use_index 0";
      Mod4-Shift-1       = "move_index 0";
      Mod4-2             = "use_index 1";
      Mod4-Shift-2       = "move_index 1";
      Mod4-3             = "use_index 2";
      Mod4-Shift-3       = "move_index 2";
      Mod4-4             = "use_index 3";
      Mod4-Shift-4       = "move_index 3";
    };
    mousebinds = {
      Mod4-Button1 = "move";
      Mod4-Button2 = "zoom";
      Mod4-Button3 = "resize";
    };
    tags = [ "web" "code" "mail" "remote" ];
    settings = {
      tree_style = "╾│ ├└╼─┐";
      frame_border_width = 2;
      show_frame_decorations = "focused_if_multiple";
      frame_bg_transparent = "on";
      frame_transparent_width = 0;
      frame_gap = 10;
      window_gap = 0;
      frame_padding = 0;
      smart_window_surroundings = false;
      smart_frame_surroundings = true;
      mouse_recenter_gap = 0;
    };
    rules = [
      "focus=on"
      "floatplacement=smart"
      "class='Gcr-prompter' manage=on floating=on floatplacement=center"
      "windowtype~'_NET_WM_WINDOW_TYPE_(DIALOG|UTILITY|SPLASH)' floating=on floatplacement=center"
      "windowtype='_NET_WM_WINDOW_TYPE_DIALOG' focus=on floatplacement=center"
      "windowtype~'_NET_WM_WINDOW_TYPE_(NOTIFICATION|DOCK|DESKTOP)' manage=off"
      "fixedsize floating=on"
    ];
    extraConfig = ''
      herbstclient attr theme.tiling.reset 1
      herbstclient attr theme.floating.reset 1
      herbstclient attr theme.title_height 15
      herbstclient attr theme.title_when always
      herbstclient attr theme.title_font 'monospace:size=12'
      herbstclient attr theme.title_depth 5  # space below the title's baseline
      herbstclient attr theme.inner_width 0
      herbstclient attr theme.border_width 0
      herbstclient attr theme.floating.border_width 1
      herbstclient attr theme.floating.outer_width 1
      herbstclient attr theme.tiling.outer_width 1
      herbstclient set_attr theme.style_override '.tab .content { padding: 4px; }'
      herbstclient detect_monitors
      source ${config.home.homeDirectory}/.config/herbstluftwm/theme.sh
      feh --bg-fill "${config.home.homeDirectory}/Pictures/Wallpaper/gravity_falls_neon.jpg"
      eww kill
      eww open "$(hostname)"
    '';
  };
  
  home.file."hlwm_theme" = {
    source = ./theme.sh;
    target = ".config/herbstluftwm/theme.sh";
    executable = true;
  };
}
