export PATH=`/usr/bin/env ruby -e '
  defaults = %w(/bin /sbin /usr/bin /usr/sbin /usr/local/bin /usr/local/sbin)
  paths = ENV["PATH"].split(":")

  paths.delete_if do |p|
    defaults.include? p
  end

  occured = Array.new
  paths.keep_if do |a|
    if occured.include? a
      false
    else
      occured << a
      true
    end
  end

  paths.sort! {|a,b| a.length <=> b.length}

  paths.each do |p|
    defaults << p unless defaults.include? p
  end
  ENV["PATHS"] = defaults.join ":"
  puts ENV["PATHS"]
'`

export ZDIR=$HOME/.config/zsh
export ZDOTDIR=$HOME/.config/zsh
source $ZDIR/main.zsh

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
