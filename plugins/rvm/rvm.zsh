PATH=$HOME/.rvm/bin:$PATH # Add RVM to PATH for scripting

if [[ -x $HOME/.rvm/scripts/rvm ]]; then
  . $HOME/.rvm/scripts/rvm
fi

alias rvmgl='rvm gemset list'
alias rvmgla='rvm gemset list_all'
alias rvmgc='rvm gemset create'
alias rvmgu='rvm gemset use'
alias rvmgd='rvm gemset delete'

alias rvml='rvm list'
alias rvmlk='rvm list known'
alias rvmla='rvm list known'

alias rvmu='rvm use'
alias rvmud='rvm use --default'

alias rvmi='rvm install'
alias rvmd='rvm remove'
alias rvmup='rvm get'
alias rvmug='rvm upgrade'
