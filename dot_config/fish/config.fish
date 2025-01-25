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

    # # With out this Starship shifts the prompt over 2 chars when pressing tab.
    # export LC_ALL="en_CA.UTF-8"

    # # eza (ls replacement)
    # zsh
    # export eza_params=('--git' '--icons' '--classify' '--group-directories-first' '--group')
    # fish
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
    # export MANPAGER="sh -c 'col -bx | bat -l man -p'"
    # export MANROFFOPT="-c"

    # # Bun
    # if [ -d "$HOME/.local/share/reflex/bun" ]; then
    #     export BUN_INSTALL="$HOME/.local/share/reflex/bun"
    #     export PATH="$BUN_INSTALL/bin:$PATH"
    # fi

end
