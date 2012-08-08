hook_opt_set=()
hook_opt_unset=()
hook_prompt=()

function hook_register() {
	hook=$1
	callback=$2
	if [[ $hook == 'opt_set' ]]; then
		hook_opt_set[${#hook_opt_set}+1]=$callback
	elif [[ $hook == 'opt_unset' ]]; then
		hook_opt_unset[${#hook_opt_unset}+1]=$callback
	elif [[ $hook == 'prompt' ]]; then
		hook_prompt[${#prompt}+1]=$callback
	fi
}

function hook_run() {
	hook=$1
	argv=$2
	callbacks=()
	if [[ hook == 'opt_set' ]]; then
		callbacks = $hook_opt_set
	elif [[ hook == 'opt_unset' ]]; then
		callbacks = $hook_opt_unset
	elif [[ hook == 'opt_set' ]]; then
		callbacks = $hook_prompt
	fi
	for callback in $callbacks; do
		${callback}( $argv )
	done
}

