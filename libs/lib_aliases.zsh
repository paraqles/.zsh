alias zshrc='source $ZDIR/main.zsh'

for al in `ls $ZDIR/aliases/aliases.*.zsh`; do
  source $al
done
