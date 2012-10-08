alias zshrc='source ~/.zshrc'

for al in `ls $ZSH_DIR/aliases/aliases.*.zsh`; do
  source $al
done
