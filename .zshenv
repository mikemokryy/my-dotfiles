
. "$HOME/.cargo/env"

# Use Fish nvm's Node 24 in non-interactive zsh sessions, including Codex.
if [[ -x "$HOME/.local/share/nvm/v24.15.0/bin/node" ]]; then
  path=("$HOME/.local/share/nvm/v24.15.0/bin" $path)
  export PATH
fi

if [[ -r "$HOME/.env" ]]; then
  set -a
  . "$HOME/.env"
  set +a
fi
