ZSH_THEMES=$ZDOTDIR/themes

if [[ $ZSH_THEME != "" ]]; then
  source $ZSH_THEMES/$ZSH_THEME/$ZSH_THEME.zsh
fi
