export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="lambda"

plugins=(
	brew
	asdf
	dotenv
	docker
	kubectl
	git
)

alias rm=trash

source $ZSH/oh-my-zsh.sh

