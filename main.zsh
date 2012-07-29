ZSH_LIB=$ZSH/lib
ZSH_PLUGIN=$ZSH/plugins

for module in $ZSH_MODULES; do
  module_dir=""
  if [[ $module = lib_* ]]; then
    module_dir=$ZSH_LIB/$module.zsh
  elif [[ $module = plg_* ]]; then
    module_dir=$ZSH_PLUGIN/${module[3,-1]}/init.zsh
  fi
  . $module_dir
done
