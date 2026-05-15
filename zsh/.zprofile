source ~/.orbstack/shell/init.zsh 2>/dev/null || :

export PIP_REQUIRE_VIRTUALENV=true

export PATH="$(mise where postgres)/bin:$PATH"

alias backup=/opt/workspace/personal/tools/backup.sh

alias beets=/opt/workspace/personal/tools/beets.sh

alias vim=nvim

export EDITOR="nvim"

chat() {
  uv tool run llm chat -o temperature 0
}

alias chat='noglob chat'

alias claude='claude --dangerously-skip-permissions'
