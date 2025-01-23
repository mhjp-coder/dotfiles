if status is-interactive

    set fish_greeting

    # eza
    alias l='eza --header $eza_params'
    alias ll='eza --header --long $eza_params'
    alias ls='eza --all --header --long $eza_params'
    alias la='eza -lbhHigUmuSa'
    alias lt='eza --tree $eza_params --level 3'
    alias tree='eza --tree $eza_params --level 3'

    # ip
    alias ip='ip -c'
    alias ipbr='ip -br -c addr show'

    # virtualenv
    alias aenv='source .venv/bin/activate'
    alias denv='deactivate'

    # Python
    alias uvi='uv init'
    alias uvs='uv sync'
    alias uvp='uv pip'

    # Misc
    alias cat='bat'
    alias zd='z $HOME/Developer'
    alias sc='source $HOME/.zshrc'
    alias c='clear'
    alias fixpacman='sudo rm /var/lib/pacman/db.lck'
    alias tarnow='tar -acf '
    alias untar='tar -zxvf '
    alias wget='wget -c '
    alias rmpkg='sudo pacman -Rcns '
    alias psmem='ps auxf | sort -nr -k 4'
    alias psmem10='ps auxf | sort -nr -k 4 | head -10'
    alias ..='cd ..'
    alias ...='cd ../..'
    alias ....='cd ../../..'
    alias grep='grep --color=auto'
    alias fgrep='grep -F --color=auto'
    alias egrep='grep -E --color=auto'
    alias hw='hwinfo --short'

    # Chezmoi
    alias cz='chezmoi '
    alias czcd='chezmoi cd'
    alias cza='chezmoi add '
    alias czra='chezmoi re-add '
    alias czu='chezmoi update'
    alias czap='chezmoi apply'
    alias cze='chezmoi edit --apply '
    alias czs='chezmoi status'
    alias czd='chezmoi doctor'
    alias czf='chezmoi forget '


    function starship_transient_prompt_func
        starship module character
    end
    starship init fish | source
    enable_transience
end
