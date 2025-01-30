function psmem10 --wraps='ps auxf | sort -nr -k 4 | head -10' --description 'alias psmem10 ps auxf | sort -nr -k 4 | head -10'
  ps auxf $argv | sort -nr -k 4 | head -10
end
