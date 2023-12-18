{ ... }: {
    programs.tmux = {
        enable = true;
        baseIndex = 1;
        historyLimit = 1000000;
        prefix = "C-a";
        keyMode = "vi";
        customPaneNavigationAndResize = true;
        mouse = true;
        resizeAmount = 10;
        escapeTime = 0;
        extraConfig = ''
            set -g renumber-windows on
            set -g allow-rename off

            set -g default-terminal screen-256color
            set -ag terminal-overrides ",xterm-256color:RGB"

            bind-key -T copy-mode-vi 'v' send -X begin-selection
            bind-key -T copy-mode-vi 'y' send -X copy-selection-and-cancel
            bind | split-window -h
            bind - split-window -v
            unbind '"'
            unbind %

            set -g pane-border-style "fg=colour240 bg=black"
            set -g pane-active-border-style "fg=colour240 bg=black"
            set -g status-bg black
            set -g status-fg white
            set -g status-style dim
            setw -g window-status-current-style "fg=black bg=colour240 bold"
            setw -g window-status-current-format " #[fg=black]#I:#[fg=white]#W#F "
            setw -g window-status-style "fg=white, bg=black"
            setw -g window-status-format " #I#[fg=colour237]:#[fg=colour250]#W#[fg=colour244]#F "

            set -g status-left ""
            set -g status-right "#[fg=white,bg=colour237] %m/%d #[fg=black,bg=black] #[fg=black,bg=colour249] %H:%M:%S "
            set -g status-interval 1
        '';
    };
}
