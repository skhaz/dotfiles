source ~/.orbstack/shell/init.zsh 2>/dev/null || :

export PIP_REQUIRE_VIRTUALENV=true

alias backup=~/Documents/backup.sh

alias vim=nvim

export EDITOR="nvim"

chat() {
  uv tool run llm "$@"
}
