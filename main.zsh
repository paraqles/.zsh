ZSH=$HOME/.zsh
ZSH_LIBS=$ZSH/libs
ZSH_PLUGINS=$ZSH/plugins

ZSH_BASE_MODULES=(
lib_utils
lib_hook
lib_prompt
lib_options
lib_history
lib_keybinding
lib_theme
lib_completion
lib_alias
lib_ls
)
for zsh_base_mod in $ZSH_BASE_MODULES; do
  . $ZSH_LIBS/$zsh_base_mod.zsh
done

for zsh_mod in $ZSH_MODULES; do
  module=""
  if [[ $zsh_mod = lib_* ]]; then
    module=$ZSH_LIBS/$zsh_mod.zsh
  elif [[ $zsh_mod = plg_* ]]; then
    module=$ZSH_PLUGINS/${zsh_mod[5,-1]}/${zsh_mod[5,-1]}.zsh
  fi
  . $module
done
