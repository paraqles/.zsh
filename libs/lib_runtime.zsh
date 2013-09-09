ZSH_RUNTIME_DIR=$ZDIR/runtimes

for runtime in `ls $ZSH_RUNTIME_DIR/*`; do
  if [[ -d $runtime ]]; then
    source $runtime/${runtime:-1:(${#runtime} - `expr match "$runtime" '/.*$'`)}.zsh
  fi
done
