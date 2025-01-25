
    # eza
    alias l         'eza --header $eza_params'
    alias ll 'eza --header --long $eza_params' --save
    alias ls 'eza --all --header --long $eza_params' --save
    alias la 'eza -lbhHigUmuSa' --save
    alias lt 'eza --tree $eza_params --level 3' --save
    alias tree 'eza --tree $eza_params --level 3' --save

    alias gs 'git' --save
    alias showip 'ip -br -c addr show' --save
    alias ip 'ip -c addr show'  --save
    alias uvi 'uv init' --save
    alias uvs 'uv sync' --save
    alias uva 'uv add' --save
    alias uvr 'uv remove' --save
    alias cat 'bat' --save
    alias zd 'z $HOME/Developer' --save
    alias sc '$HOME/.config/fish/config.fish | source' --save
    alias tarnow 'tar -acf ' --save
    alias untar 'tar -zxvf ' --save
    alias fixpacman 'sudo rm /var/lib/pacman/db.lck' --save
    alias rmpkg 'paru -Rcns ' --save
    alias psmem 'ps auxf | sort -nr -k 4' --save
    alias psmem10 'ps auxf | sort -nr -k 4 | head -10' --save
    alias grep 'grep --color=auto' --save
    alias fgrep 'grep -F --color=auto' --save
    alias egrep 'grep -E --color=auto' --save
    alias hw 'hwinfo --short' --save
    alias cz 'chezmoi ' --save
    alias czcd 'chezmoi cd' --save
    alias czra 'chezmoi re-add ' --save
    alias czap 'chezmoi apply' --save
    alias cza 'chezmoi add ' --save
    alias czu 'chezmoi update' --save
    alias cze 'chezmoi edit --apply ' --save
    alias czs 'chezmoi status' --save
    alias czd 'chezmoi doctor' --save
    alias czf 'chezmoi forget ' --save
    alias vim 'nvim' --save
    alias vi 'nvim' --save
    alias v 'nvim' --save
