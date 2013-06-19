for zsh_plg in $ZSH_PLUGINS; do
  plugin=""
  if [[ $zsh_plg = lib_* ]]; then
    plugin=$ZSH_LIBS_DIR/$zsh_plg.zsh
  elif [[ $zsh_plg = plg_* ]]; then
    plugin=$ZSH_PLUGINS_DIR/${zsh_plg[5,-1]}/${zsh_plg[5,-1]}.zsh
  fi
  source $plugin
done

zsh_update_plugins() {
  old_pwd=`pwd`
  cd $ZSH_DIR
  git submodule foreach "git checkout master; git pull"
  cd $old_pwd
}
