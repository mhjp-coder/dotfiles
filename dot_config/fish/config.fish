if status is-interactive

    # Disable Greeting
    set fish_greeting

    # Homebrew
    test -e /opt/homebrew/bin/brew; and eval (/opt/homebrew/bin/brew shellenv)

    # # Fastfetch
    # fastfetch

    # # eza (ls replacement)
    set -x eza_params --git --icons --classify --group-directories-first --group

    # FZF
    fzf --fish | source
    set -x FZF_DEFAULT_OPTS "\
        --preview 'fzf-preview.sh {}' \
        --preview-window 'right:60%' \
        --height=50% \
        --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
        --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
        --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
        --color=selected-bg:#45475a \
        --multi"

    # # Bat colorizing pager for manpages
    set -x MANPAGER "sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"

    # Bun
    if test -d "$HOME/.local/share/reflex/bun"
        set -x BUN_INSTALL "$HOME/.local/share/reflex/bun"
        fish_add_path $BUN_INSTALL/bin
    end

    # Direnv
    set -g direnv_fish_mode eval_on_arrow
    direnv hook fish | source

    # Zoxide
    zoxide init fish --cmd cd | source

    # Starship Prompt
    starship init fish | source
    enable_transience



end
