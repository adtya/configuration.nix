{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    clock24 = true;
    escapeTime = 0;
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = dracula;
        extraConfig = ''
          set -g @dracula-show-powerline true
          set -g @dracula-plugins "time"
          set -g @dracula-show-timezone false
          set -g @dracula-day-month true
          set -g @dracula-show-flags true
          set -g @dracula-show-left-icon session
        '';
      }
    ];
    extraConfig = ''
      set -g update-environment 'TERM DISPLAY WAYLAND_DISPLAY SWAYSOCK HYPRLAND_INSTANCE_SIGNATURE XDG_CURRENT_DESKTOP'
      if "[[ ''${TERM} == xterm-kitty ]]" "set-option -sa terminal-features ',xterm-kitty:RGB'"
      set -g default-terminal tmux-256color
      set -g allow-rename on
      set -g set-titles on
      set -g set-titles-string "#W"
      set -g automatic-rename on
      set -g automatic-rename-format '(#{b:pane_current_path}) #{pane_current_command}'
      set -g status-position top
      set -g status-interval 1
      set -g mouse on
      set -g allow-passthrough on

      set -g monitor-activity off
      set -g monitor-bell off
      set -g visual-activity off
      set -g visual-bell off

      set -g renumber-windows on
      set -g base-index 1
      setw -g pane-base-index 1

      bind - split-window -v -c "#{pane_current_path}"
      bind \\ split-window -h -c "#{pane_current_path}"
    '';
  };
}
