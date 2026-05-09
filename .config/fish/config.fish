# NVM setup
set -x NVM_DIR ~/.nvm

# NVM
function _nvm_use_on_cd --on-variable PWD --description 'Do nvm stuff'
    nvm use --silent
end

if set -q nvm_current_version
    set -p PATH $HOME/.local/share/nvm/$nvm_current_version/bin
end

# Global variables
set -gx TERM tmux-256color
set -gx EDITOR nvim

# NodeJS
set -gx PATH node_modules/.bin $PATH

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH

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
# Style: terafox
# Upstream: https://github.com/edeneast/nightfox.nvim/raw/main/extra/terafox/terafox.fish
# set -l foreground e6eaea
# set -l selection 293e40
# set -l comment 6d7f8b
# set -l red e85c51
# set -l orange ff8349
# set -l yellow fda47f
# set -l green 7aa4a1
# set -l purple ad5c7c
# set -l cyan a1cdd8
# set -l pink cb7985

# Nightfox Color Palette
# Style: nightfox
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

# Kanagawa Fish shell theme
# A template was taken and modified from Tokyonight:
# https://github.com/folke/tokyonight.nvim/blob/main/extras/fish_tokyonight_night.fish
# set -l foreground DCD7BA
# set -l selection 2D4F67
# set -l comment 727169
# set -l red C34043
# set -l orange FF9E64
# set -l yellow C0A36E
# set -l green 76946A
# set -l purple 957FB8
# set -l cyan 7AA89F
# set -l pink D27E99

# TokyoNight Color Palette
# set -l foreground c0caf5
# set -l selection 364a82
# set -l comment 565f89
# set -l red f7768e
# set -l orange ff9e64
# set -l yellow e0af68
# set -l green 9ece6a
# set -l purple 9d7cd8
# set -l cyan 7dcfff
# set -l pink bb9af7

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
alias c claude
alias icat="kitty +kitten icat --align=left"

command -qv nvim && alias nv nvim
command -qv lazygit && alias lg lazygit

if type -q exa
    alias ll "exa -l -g --icons"
    alias lla "ll -a"
end

# Added by `rbenv init` on Mon Apr 13 12:25:35 EEST 2026
status --is-interactive; and rbenv init - --no-rehash fish | source

# fix prompt problem

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /Users/mikhailomokryi/miniforge3/bin/conda
    eval /Users/mikhailomokryi/miniforge3/bin/conda "shell.fish" hook $argv | source
else
    if test -f "/Users/mikhailomokryi/miniforge3/etc/fish/conf.d/conda.fish"
        . "/Users/mikhailomokryi/miniforge3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH /Users/mikhailomokryi/miniforge3/bin $PATH
    end
end
# <<< conda initialize <<<
