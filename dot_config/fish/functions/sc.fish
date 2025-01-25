function sc --wraps='$HOME/.config/fish/config.fish | source' --description 'alias sc $HOME/.config/fish/config.fish | source'
  $HOME/.config/fish/config.fish | source $argv
        
end
