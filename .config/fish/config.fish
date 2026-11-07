# Environment -----------------------------------------------------------------
set -gx LANG en_US.UTF-8
set -gx EDITOR nvim
set -gx XDG_CONFIG_HOME $HOME/.config

# Abbreviate parent directories in prompt_pwd
set -g fish_prompt_pwd_dir_length 1

# PATH --------------------------------------------------------------------------
# fish_add_path is idempotent: re-sourcing never duplicates entries.
fish_add_path -g ~/.local/bin ~/bin ~/.cargo/bin

# Shared environment from ~/.env ------------------------------------------------
if test -r $HOME/.env
    for line in (string match -r '^[A-Za-z_][A-Za-z0-9_]*=.*' <$HOME/.env)
        set -l entry (string split -m 1 = -- $line)
        set -gx $entry[1] $entry[2]
    end
end

# Aliases -----------------------------------------------------------------------
alias ls "ls -p -G"
alias la "ls -A"
alias ll "ls -l"
alias lla "ll -A"
alias g git

command -qv nvim && alias nv nvim
command -qv nvim && alias vim nvim
command -qv lazygit && alias lg lazygit
if type -q eza
    alias ll "eza -l -g --icons=auto"
    alias lla "ll -a"
end

# Theme (fish applies the default theme at startup; re-apply ours) ----------------
status is-interactive; and fish_config theme choose terafox

# Tools (interactive shells only) ------------------------------------------------
status is-interactive; and type -q fzf; and fzf --fish | source
status is-interactive; and type -q rbenv; and rbenv init - --no-rehash fish | source
status is-interactive; and type -q zoxide; and zoxide init fish | source

# Node (nvm) ---------------------------------------------------------------------
# Interactive only: non-interactive scripts should not mutate PATH on cd.
if status is-interactive
    # Auto-switch node version on cd (if .nvmrc or .node-version exists).
    function _nvm_use_on_cd --on-variable PWD --description 'Do nvm stuff'
        type -q nvm; and nvm use --silent
    end

    # nvm's conf.d already activates the default version, but fish_add_path
    # above rebuilds PATH, so re-run nvm use to put its node bin back in front
    # of Homebrew's. Erase nvm_current_version first: it can be inherited by
    # child shells.
    set --erase nvm_current_version
    type -q nvm; and nvm use --silent
end

# Conda --------------------------------------------------------------------------
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /opt/homebrew/Caskroom/miniforge/base/bin/conda
    eval /opt/homebrew/Caskroom/miniforge/base/bin/conda "shell.fish" hook $argv | source
else
    if test -f "/opt/homebrew/Caskroom/miniforge/base/etc/fish/conf.d/conda.fish"
        . "/opt/homebrew/Caskroom/miniforge/base/etc/fish/conf.d/conda.fish"
    else
        set -x PATH /opt/homebrew/Caskroom/miniforge/base/bin $PATH
    end
end
# <<< conda initialize <<<
