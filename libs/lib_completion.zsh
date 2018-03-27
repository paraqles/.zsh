autoload -Uz compinit; compinit
zmodload -i zsh/complist

zstyle ':completion:*:*:*:*:*' menu select

zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $ZDIR/cache

zstyle ':completion:*' matcher-list "m:{a-zA-Z}={A-Za-z}" "r:|[._-]=* r:|=*" "l:|=* r:|=*" "l:|=** r:|=**"

zstyle ':completion:*:descriptions' format 'Candidates for %F{blue}%d%f:'
zstyle ':completion:*' list-seperator '#'

# ignore completion functions for unkown commands
zstyle ':completion:*:functions' ignore-patterns '_*'

# should this be in keybindings?
bindkey -M menuselect '^o' accept-and-infer-next-history

zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"

# disable named-directories autocompletion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:(cd|mv|cp):*' ignore-parents parent pwd
cdpath=(.)

# completion only if at beginning or when '.'
zstyle -e ':completion:*' special-dirs '[[ $PREFIX = (../)#(|.|..) ]] && reply=(..)'

# ignore filenames already on line
zstyle ':completion:*:(rm|kill|touch|diff|vim|gvim)' ignore-line yes

# use /etc/hosts and known_hosts for hostname completion
[[ -r /etc/ssh/ssh_known_hosts ]] && _global_ssh_hosts=(${${${${(f)"$(</etc/ssh/ssh_known_hosts)"}:#[\|]*}%%\ *}%%,*}) || _ssh_hosts=()
[ -r ~/.ssh/known_hosts ] && _ssh_hosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[\|]*}%%\ *}%%,*}) || _ssh_hosts=()

[ -r /etc/hosts ] && : ${(A)_etc_hosts:=${(s: :)${(ps:\t:)${${(f)~~"$(</etc/hosts)"}%%\#*}##[:blank:]#[^[:blank:]]#}}} || _etc_hosts=()
[ -r ~/.ssh/config ] && _ssh_config=($(cat ~/.ssh/config | sed -ne 's/Host[=\t ]//p')) || _ssh_config=()

hosts=(
  "$_global_ssh_hosts[@]"
  "$_ssh_hosts[@]"
  "$_etc_hosts[@]"
  "$_ssh_config[@]"
  "$HOST"
  localhost
)
zstyle ':completion:*:hosts' hosts $hosts

# Don't complete uninteresting users
zstyle ':completion:*:*:*:users' ignored-patterns \
        adm amanda apache avahi beaglidx bin cacti canna clamav daemon \
        dbus distcache dovecot fax ftp games gdm gkrellmd gopher \
        hacluster haldaemon halt hsqldb ident junkbust ldap lp mail \
        mailman mailnull mldonkey mysql nagios \
        named netdump news nfsnobody nobody nscd ntp nut nx openvpn \
        operator pcap postfix postgres privoxy pulse pvm quagga radvd \
        rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs

# ... unless we really want to.
zstyle '*' single-ignored show

if [ "x$COMPLETION_WAITING_DOTS" = "xtrue" ]; then
  expand-or-complete-with-dots() {
    echo -n "\e[31m......\e[0m"
    zle expand-or-complete
    zle redisplay
  }
  zle -N expand-or-complete-with-dots
  bindkey "^I" expand-or-complete-with-dots
fi

zstyle :compinstall filename "$ZDIR/.zshrc"
