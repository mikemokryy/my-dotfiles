# Auto-switch node version on cd (if .nvmrc or .node-version exists)
function _nvm_use_on_cd --on-variable PWD --description 'Do nvm stuff'
    nvm use --silent
end

# Global variables
set -gx TERM tmux-256color
set -gx EDITOR nvim

# NodeJS
set -gx PATH node_modules/.bin $PATH

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH
set -gx PATH ~/.cargo/bin $PATH

# Use brew llvm instead of system clang
set -gx LDFLAGS -L/opt/homebrew/opt/llvm/lib
set -gx CPPFLAGS -I/opt/homebrew/opt/llvm/include

# For cmake to find llvm you may need to set:
set -gx CMAKE_PREFIX_PATH /opt/homebrew/opt/llvm

# Set default config path
set -gx XDG_CONFIG_HOME $HOME/.config

# Set up fzf key bindings
fzf --fish | source

# theme
set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_powerline_fonts no
set -g theme_nerd_fonts yes
set -g theme_date_format "+%H:%M"
set -g theme_display_cmd_duration yes
set -g theme_use_abbreviated_branch_name yes

# Nightfox Color Palette
# Upstream: https://github.com/edeneast/nightfox.nvim/raw/main/extra/nightfox/nightfox.fish
set -l foreground cdcecf
set -l selection 2b3b51
set -l comment 738091
set -l red c94f6d
set -l orange f4a261
set -l yellow dbc074
set -l green 81b29a
set -l purple 9d79d6
set -l cyan 63cdcf
set -l pink d67ad2

# Syntax Highlighting Colors
set -g fish_color_normal $foreground
set -g fish_color_command $cyan
set -g fish_color_keyword $pink
set -g fish_color_quote $yellow
set -g fish_color_redirection $foreground
set -g fish_color_end $orange
set -g fish_color_error $red
set -g fish_color_param $purple
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $green
set -g fish_color_escape $pink
set -g fish_color_autosuggestion $comment

# Completion Pager Colors
set -g fish_pager_color_progress $comment
set -g fish_pager_color_prefix $cyan
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment
set -g fish_pager_color_selected_background --background=$selection

# aliases
alias ls "ls -p -G"
alias la "ls -A"
alias ll "ls -l"
alias lla "ll -A"
alias g git
alias icat="kitty +kitten icat --align=left"

command -qv nvim && alias nv nvim
command -qv lazygit && alias lg lazygit

if type -q eza
    alias ll "eza -l -g --icons=auto"
    alias lla "ll -a"
end

# Keep nvm's active Node ahead of Homebrew's Node. nvm_current_version can be
# inherited by child shells, so erase it before re-running nvm use.
if status is-interactive
    set --erase nvm_current_version
    nvm use --silent
end

# Added by `rbenv init` on Mon Apr 13 12:25:35 EEST 2026
status --is-interactive; and rbenv init - --no-rehash fish | source

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
