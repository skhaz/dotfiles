export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="lambda"

plugins=(
	brew
	docker
  dotenv
	git
	mise
  tmux
)

source $ZSH/oh-my-zsh.sh

export $(cat $HOME/.env | xargs)


. "/tmp/wippy-test-mac/env"
