{ pkgs, ... }: {
    home.packages = with pkgs; [
        fishPlugins.forgit
        fishPlugins.foreign-env
    ];

    programs.fish = {
        enable = true;
        interactiveShellInit = builtins.readFile ./fish/interactive.fish;
        shellInit = builtins.readFile ./fish/init.fish;
        shellAliases = {
            cp = "cp -v";
            mv = "mv -iv";
            rm = "rm -vI";
            rcp = "rsync -avzhP --stats";
            ip = "ip --color=auto";
            one = "ping -c 5 1.1.1.1";
            vrc = "nvim ~/dev/git/dotfiles/nvim/init.lua ~/dev/git/dotfiles/nvim/lua/plugins.lua";
            sx = "nsxiv -b -a";
            z = "zathura --fork";
            npm = "pnpm";
        };
        shellAbbrs = {
            k = "kubectl";
            g = "git";
            d = "docker";
        };
        functions = {
            fish_prompt = builtins.readFile ./fish/fish_prompt.fish;
            fish_right_prompt = builtins.readFile ./fish/fish_right_prompt.fish;
            fish_default_mode_prompt = "";
        };
    };
}
