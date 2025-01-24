if status is-interactive

    # Homebrew
    test -e /opt/homebrew/bin/brew; and eval (/opt/homebrew/bin/brew shellenv)

    # Disable Greeting
    set fish_greeting

    # eza
    alias l='eza --header $eza_params'
    alias ll='eza --header --long $eza_params'
    alias ls='eza --all --header --long $eza_params'
    alias la='eza -lbhHigUmuSa'
    alias lt='eza --tree $eza_params --level 3'
    alias tree='eza --tree $eza_params --level 3'

    # Vim
    alias vim='nvim'
    alias vi='nvim'
    alias v='nvim'

    # ip
    alias ip='ip -c'
    alias showip='ip -br -c addr show'

    # Python
    alias uvi='uv init'
    alias uvs='uv sync'
    alias uva='uv add'
    alias uvr='uv remove'

    # Misc
    alias cat='bat'
    alias zd='z $HOME/Developer'
    alias sc='$HOME/.config/fish/config.fish | source'
    alias tarnow='tar -acf '
    alias untar='tar -zxvf '
    alias fixpacman='sudo rm /var/lib/pacman/db.lck'
    alias rmpkg='paru -Rcns '
    alias psmem='ps auxf | sort -nr -k 4'
    alias psmem10='ps auxf | sort -nr -k 4 | head -10'
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

    # fzf
    eval (fzf --fish)

    # Zoxide
    eval (zoxide init --cmd cd fish)

    # Evaluate keychain
    SHELL=/bin/fish keychain --eval --quiet -Q id_ed25519 | source

    # Starship prompt
    function starship_transient_prompt_func
        starship module character
    end

    eval (starship init fish)
    enable_transience

    # Fastfetch
    fastfetch

    # # With out this Starship shifts the prompt over 2 chars when pressing tab.
    # export LC_ALL="en_CA.UTF-8"

    # # eza (ls replacement)
    # export eza_params=('--git' '--icons' '--classify' '--group-directories-first' '--group')

    # # FZF
    # export FZF_DEFAULT_OPTS=" \
    # --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
    # --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
    # --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
    # --color=selected-bg:#45475a \
    # --multi"


    # # Bat colorizing pager for manpages
    # export MANPAGER="sh -c 'col -bx | bat -l man -p'"
    # export MANROFFOPT="-c"

    # # Bun
    # if [ -d "$HOME/.local/share/reflex/bun" ]; then
    #     export BUN_INSTALL="$HOME/.local/share/reflex/bun"
    #     export PATH="$BUN_INSTALL/bin:$PATH"
    # fi

end
