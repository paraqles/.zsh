alias zshrc='source $ZDOTDIR/main.zsh'

for al in `ls $ZDOTDIR/aliases/aliases.*.zsh`; do
  source $al
done
