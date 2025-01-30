function darwin-rebuild-switch --wraps='darwin-rebuild switch --flake ~/.config/nix-darwin/' --description 'alias darwin-rebuild-switch darwin-rebuild switch --flake ~/.config/nix-darwin/'
  darwin-rebuild switch --flake ~/.config/nix-darwin/ $argv
        
end
