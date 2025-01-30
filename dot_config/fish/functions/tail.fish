function tail --wraps='tail' --description 'alias tail with bat to colorize logs'
    tail $argv | bat --paging=never -l log
end
