for f in `ls $ZDIR/functions/func.*.zsh`; do
  source $f
done

for zsh_ext in $ZSH_EXTENSIONS; do
  if [[ $zsh_ext = ext_* ]]; then
    old_pwd=`pwd`

    cd $ZSH_EXTENSIONS_DIR/${zsh_ext[5,-1]}

    # Check if files to source are available
    # otherwise silently move on.
    if [[ `print -l func.*.zsh(.N)` ]]; then
      for f in `ls func.*.zsh`; do
        source $f
      done
    fi

    # Restore old working dir
    cd $old_pwd
    unset old_pwd
  fi
done
