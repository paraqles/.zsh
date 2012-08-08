autoload -Uz compinit; compinit
zmodload -i zsh/complist

zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

#machter_lu="m:{[:lower:]}={[:upper:]}"
#matcher_ul="m:{[:upper:}}={[:lower:]}"
#matcher_luul="m:{[:lower:][:upper:]}={[:upper:][:lower:]}"
#matcher_ullu="m:{[:upper:][:lower:]}={[:lower:][:upper:]}"
#matcher_wwrap="r:|[._-\ ]=** r:|=** l:|=*"

#matcher_list_param="$matcher_lu $matcher_ul $matcher_luul $matcher_ullu $matcher_wwrap"
#matcher_olist_param="$matcher_lu $matcher_ul $matcher_luul $matcher_ullu $matcher_wwrap"
#matcher_expand_param="$matcher_lu $matcher_ul $matcher_luul $matcher_ullu $matcher_wwrap"
#matcher_complete_param="$matcher_lu $matcher_ul $matcher_luul $matcher_ullu $matcher_wwrap"
#matcher_ignored_param="$matcher_lu $matcher_ul $matcher_luul $matcher_ullu $matcher_wwrap"
#matcher_match_param="$matcher_lu $matcher_ul $matcher_luul $matcher_ullu $matcher_wwrap"
#matcher_correct_param="$matcher_lu $matcher_ul $matcher_luul $matcher_ullu $matcher_wwrap"
#matcher_approximate_param="$matcher_lu $matcher_ul $matcher_luul $matcher_ullu $matcher_wwrap"

#zstyle ':completion:*' matcher-list "$matcher_list_param $matcher_olist_param $matcher_expand_param $matcher_complete_param $matcher_ignored_param $matcher_match_param $matcher_correct_param $matcher_approximate_param"

zstyle ':completion:*:descriptions' format 'Candidates for %B%d%B:'
zstyle ':completion:*' list-seperator '#'

zstyle :compinstall filename '/home/paraqles/.zshrc'
