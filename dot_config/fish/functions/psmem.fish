function psmem --wraps='ps auxf | sort -nr -k 4' --description 'alias psmem ps auxf | sort -nr -k 4'
  ps auxf $argv | sort -nr -k 4
end
