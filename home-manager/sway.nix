 { pkgs, config, lib, ... }: {

    systemd.user.services.autotiling = {
        Install = {
            WantedBy = [ "sway-session.target" ];
            PartOf = [ "graphical-session.target" ]; 
        }; Service = {
            ExecStart = "${pkgs.autotiling-rs}/bin/autotiling-rs";
            Restart = "always";
            RestartSec = 5;
        };
    };

    programs = {
        swaylock = {
            enable = true;
            settings = {
                no-unlock-indicator = true;
                color = "0d686b";
            };
        };

        i3status-rust = {
            enable = true;
            bars = {
                default = {
                    theme = "native";
                    icons = "awesome6";
                    blocks = [
                        {
                            block = "focused_window";
                            format.full = " $title.str(max_w:25) |";
                            format.short = " $title.str(max_w:15) |";
                        }
                        {
                            block = "memory";
                            format = " $icon $mem_used.eng(w:3,u:B,p:M) ";
                        }
                        {
                            block = "net";
                            format = " $icon { $signal_strength $ssid| wired} ";
                        }
                        {
                            block = "sound";
                        }
                        {
                            block = "battery";
                            interval = 10;
                            full_format = " $icon  charged ";
                            format = " $icon  $percentage ";
                            if_command = "test -e /sys/class/power_supply/BAT0";
                        }
                        {
                            block = "time";
                            interval = 1;
                            format = " $timestamp.datetime(f:'%a %h %d %r') ";
                        }
                    ];
                };
            };
        };
    };

    services = {
        gammastep = {
            enable = true;
            latitude = 45.0;
            longitude = -90.0;
        };

        swayidle = {
            enable = true;
            events = [{
                event = "before-sleep";
                command = "${pkgs.swaylock}/bin/swaylock";
            }];
            timeouts = [
            {
                timeout = 600;
                command = "${pkgs.swaylock}/bin/swaylock";
            }
            {
                timeout = 900;
                command = ''swaymsg "output * power off"'';
                resumeCommand = ''swaymsg "output * power on"'';
            }
            ];
        };
    };

    wayland.windowManager.sway = {
        enable = true;
        config = {
            modifier = "Mod4";
            terminal = "alacritty";
            menu = "run_prompt";

            output = {
                "*".bg = "#0d686b solid_color";
                "DP-1" = {
                    resolution = "2560x1440@59.951Hz";
                    position = "1920 0";
                };
                "eDP-1" = {
                    resolution = "1920x1080@60.010Hz";
                    position = "0 0";
                };
            };

            input = {
                "type:keyboard" = {
                    repeat_delay = "200";
                    repeat_rate = "60";
                };
                "type:pointer" = {
                    accel_profile = "flat";
                    pointer_accel = "0.0";
                };
                "type:touchpad" = {
                    tap = "enabled";
                    natural_scroll = "enabled";
                    middle_emulation = "enabled";
                    accel_profile = "flat";
                    scroll_factor = "0.7";
                    tap_button_map = "lrm";
                    dwt = "true";
                };
                "type:touch" = {
                    events = "disabled";
                };

            };

            keybindings = let
                modifier = config.wayland.windowManager.sway.config.modifier;
            in lib.mkOptionDefault {
                "${modifier}+q" = "kill";
                "${modifier}+w" = "exec librewolf";
                "${modifier}+p" = "exec shot";
                "${modifier}+Shift+Control+l" = "exec swaylock";
                "${modifier}+Shift+e" = "exec swaymsg 'exit'";
                Prior = "nop";
                Next = "nop";
                "XF86AudioRaiseVolume" = "exec 'pactl set-sink-volume @DEFAULT_SINK@ +5%'";
                "XF86AudioLowerVolume" = "exec 'pactl set-sink-volume @DEFAULT_SINK@ -5%'";
                "XF86AudioMute" = "exec 'pactl set-sink-mute @DEFAULT_SINK@ toggle'";
                "XF86MonBrightnessUp" = "brightnessctl -c backlight s +1%";
                "XF86MonBrightnessDown" = "brightnessctl -c backlight s 1%-";
            };

            workspaceOutputAssign = [
                { workspace = "1"; output = "eDP-1"; }
                { workspace = "2"; output = "eDP-1"; }
                { workspace = "3"; output = "eDP-1"; }
                { workspace = "4"; output = "eDP-1"; }
                { workspace = "5"; output = "eDP-1"; }
                { workspace = "6"; output = "eDP-1"; }
                { workspace = "7"; output = "eDP-1"; }
                { workspace = "8"; output = "eDP-1"; }
                { workspace = "9"; output = "DP-1"; }
            ];

            focus.followMouse = false;

            window.border = 3;

            colors = {
                focused = {
                    border = "#999999";
                    background = "#999999";
                    text = "#000000";
                    indicator = "#999999";
                    childBorder = "#999999";
                };
                unfocused = {
                    border = "#ffffff";
                    background = "#333333";
                    text = "#000000";
                    indicator = "#333333";
                    childBorder = "#333333";
                };
            };

            gaps = {
                smartBorders = "no_gaps";
                smartGaps = true;
                inner = 8;
                outer = 8;
            };

            bars = [{
                position = "top";
                statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs config-default";
                fonts = {
                    names = [
                        "JetBrainsMono Nerd Font"
                    ];
                    size = 10.0;
                };

                colors = {
                    statusline = "#eeeeee";
                    background = "#171717";
                    focusedWorkspace = {
                        background = "#171717";
                        border = "#171717";
                        text = "#eeeeee";
                    };
                    inactiveWorkspace = {
                        background = "#171717";
                        border = "#171717";
                        text = "#888888";
                    };
                };
            }];

        };
    };
}
