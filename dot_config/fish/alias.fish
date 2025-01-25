
    # eza
    alias l         'eza --header $eza_params'
    alias ll        'eza --header --long $eza_params'
    alias ls        'eza --all --header --long $eza_params'
    alias la        'eza -lbhHigUmuSa'
    alias lt        'eza --tree $eza_params --level 3'
    alias tree      'eza --tree $eza_params --level 3'

    # Git
    alias gs        'git'


    # ip
    alias showip    'ip -br -c addr show'
    alias ip        'ip -c'

    # Python
    alias uvi       'uv init'
    alias uvs       'uv sync'
    alias uva       'uv add'
    alias uvr       'uv remove'

    # Misc
    alias cat       'bat'
    alias zd        'z $HOME/Developer'
    alias sc        '$HOME/.config/fish/config.fish | source'
    alias tarnow    'tar -acf '
    alias untar     'tar -zxvf '
    alias fixpacman 'sudo rm /var/lib/pacman/db.lck'
    alias rmpkg     'paru -Rcns '
    alias psmem     'ps auxf | sort -nr -k 4'
    alias psmem10   'ps auxf | sort -nr -k 4 | head -10'
    alias grep      'grep --color=auto'
    alias fgrep     'grep -F --color=auto'
    alias egrep     'grep -E --color=auto'
    alias hw        'hwinfo --short'

    # Chezmoi
    alias cz        'chezmoi '
    alias czcd      'chezmoi cd'
    alias cza       'chezmoi add '
    alias czra      'chezmoi re-add '
    alias czu       'chezmoi update'
    alias czap      'chezmoi apply'
    alias cze       'chezmoi edit --apply '
    alias czs       'chezmoi status'
    alias czd       'chezmoi doctor'
    alias czf       'chezmoi forget '

    # Vim
    alias vim       'nvim'
    alias vi        'nvim'
    alias v         'nvim'
