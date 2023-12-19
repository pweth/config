/*
* tmux configuration.
*/

{ config, ... }:

{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    mouse = true;
    extraConfig = ''
      set -g pane-active-border-style 'bg=default fg=colour239'
      set -g pane-border-style 'bg=default fg=colour236'
      set -g status-interval 1
      set -g status-left '''
      set -g status-position top
      set -g status-right '#[fg=colour231, bg=colour233] #{session_name} → #(hostname) '
      set -g status-style 'bg=default fg=colour137'
      setw -g window-status-current-format ' #I #W#F '
      setw -g window-status-current-style 'fg=colour231 bg=colour233 bold'
      setw -g window-status-format ' #I #W#F '
      setw -g window-status-style 'fg=colour231 bg=colour235'
    '';
  };
}
