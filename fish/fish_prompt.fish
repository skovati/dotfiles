switch $fish_bind_mode
case default
    set_color --bold magenta
case insert
    set_color --bold green
case visual
    set_color --bold yellow
case replace_one
    set_color --bold red
case replace
    set_color --bold red
end

printf " %s " $(prompt_pwd)
set_color normal
