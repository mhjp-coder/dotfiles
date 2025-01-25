# Description: Custom functions for fish shell

# command not found handler
function fish_command_not_found
    __fish_default_command_not_found_handler $argv
end

# starship transient prompt
function starship_transient_prompt_func
    starship module character
end
