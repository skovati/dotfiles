{ config, ... }: {
    programs.mpv = {
        enable = true;
        bindings = {
            a = "cycle_values af loudnorm=lra=15:i=-15 anull";
            "ALT+j" = "add sub-scale +0.1";
            "ALT+k" = "add sub-scale -0.1";
        };
        config = {
            audio-channels = "stereo";
            hwdec = "auto";
            sub-font = "JetBrainsMono Nerd Font";
            sub-font-size = 30;
            sub = "auto";
            sub-auto = "all";
            sub-file-paths = "srt:sub:Sub:subs:Subs:subtitles:Subtitles";
            blend-subtitles = "video";
            sub-border-size = 2;
            save-position-on-quit = true;
            watch-later-directory = "${config.xdg.dataHome}/mpv/watch_later";
        };
    };
}
