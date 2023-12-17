{ ... }: {
    programs.alacritty = {
        enable = true;
        settings = {
            env = {
                TERM = "xterm-256color";
            };
            window = {
                dimensions = {
                    columns = 80;
                    lines = 30;
                };
                padding = {
                    x = 10;
                    y = 9;
                };
            };
            font = {
                normal = {
                    family = "JetBrainsMono Nerd Font";
                    style = "Regular";
                };
                bold = {
                    family = "JetBrainsMono Nerd Font";
                    style = "Bold";
                };
                size = 12;
            };
            cursor = {
                style = "Underline";
                unfocused_hollow = false;
                thickness = 0.3;
            };
            mouse = {
                hints.launcher = {
                    program = "xdg-open";
                    args = [];
                };
            };
            colors = {
                bright = {
                    black = "#ebdbb2";
                    blue = "#80aa9e";
                    cyan = "#8bba7f";
                    green = "#b0b846";
                    magenta = "#d3869b";
                    red = "#f2594b";
                    white = "#e2cca9";
                    yellow = "#e9b143";
                };
                normal = {
                    black = "#171717";
                    blue = "#80aa9e";
                    cyan = "#8bba7f";
                    green = "#b0b846";
                    magenta = "#d3869b";
                    red = "#f2594b";
                    white = "#e2cca9";
                    yellow = "#e9b143";
                };
                primary = {
                    background = "#171717";
                    foreground = "#e2cca9";
                };
            };
        };
    };
}
