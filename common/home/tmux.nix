{ ... }:

{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    mouse = true;
    extraConfig = ''
      set -g base-index 1
      set -g mouse on
      set -g pane-active-border-style 'bg=default fg=colour239'
      set -g pane-border-style 'bg=default fg=colour236'
      set -g set-clipboard off
      set -g set-titles on
      set -g status-interval 1
      set -g status-left '''
      set -g status-position top
      set -g status-right '#[fg=colour231, bg=colour233] #{session_name} → #(hostname) '
      set -g status-style 'bg=default fg=colour137'
      setw -g pane-base-index 1
      setw -g window-status-current-format ' #I #W#F '
      setw -g window-status-current-style 'fg=colour231 bg=colour233 bold'
      setw -g window-status-format ' #I #W#F '
      setw -g window-status-style 'fg=colour231 bg=colour235'
      unbind -n MouseDown3Pane
      bind-key -T copy-mode MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "xclip -selection clipboard"
      bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "xclip -selection clipboard"
    '';
  };
}
