if status is-interactive

    # Disable Greeting
    set fish_greeting

    # Zoxide
    eval (zoxide init --cmd cd fish)

    # Starship Prompt
    eval (starship init fish)
    enable_transience

    # Homebrew
    test -e /opt/homebrew/bin/brew; and eval (/opt/homebrew/bin/brew shellenv)

    # # Fastfetch
    # fastfetch

    # # eza (ls replacement)
    set -x eza_params --git --icons --classify --group-directories-first --group

    # FZF
    eval (fzf --fish)
    set -x FZF_DEFAULT_OPTS \
    "--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
    --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
    --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
    --color=selected-bg:#45475a
    --multi"

    # # Bat colorizing pager for manpages
    set -x MANPAGER "sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"

    # Bun
    if test -d "$HOME/.local/share/reflex/bun"
        set -x BUN_INSTALL "$HOME/.local/share/reflex/bun"
        fish_add_path $BUN_INSTALL/bin
    end
end
