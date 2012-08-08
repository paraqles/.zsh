ZSH_PLUGIN_GIT=$ZSH_PLUGINS/git

hook_register "prompt" "git_prompt"

function git_prompt() {
	argv=$1
}

source $ZSH_PLUGIN_GIT/aliases.zsh
