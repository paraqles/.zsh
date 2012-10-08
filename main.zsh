ZSH_DIR=$HOME/.zsh
ZSH_LIBS_DIR=$ZSH/libs
ZSH_PLUGINS_DIR=$ZSH/plugins

ZSH_MODULES=(
lib_utils
lib_hash
lib_hook
lib_options
lib_prompt
lib_history
lib_keybinding
lib_theme
lib_completion
lib_functions
lib_aliases
lib_plugins
)

for zsh_mod in $ZSH_MODULES; do
  . $ZSH_LIBS_DIR/$zsh_mod.zsh
done

