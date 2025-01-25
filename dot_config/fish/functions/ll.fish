function ll --wraps=ls --wraps='eza --header --long $eza_params' --description 'alias ll eza --header --long $eza_params'
  eza --header --long $eza_params $argv
        
end
