# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

# User specific environment and startup programs

PATH=$HOME/bin:$PATH
export PATH

# Load RVM if present
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# git completion
[[ -s $HOME/.git-completion.bash ]] && source $HOME/.git-completion.bash

# git prompt vars
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1

# Trying to use these variables in the prompt expansion seems to result
# in weirdness, so these are mostly here to help me keep track of which
# code is what color.
GREEN="\[\e[0;32m\]"
CYAN="\[\e[0;36m\]"
RESET="\[\e[0;0m\]"
export PS1='\[\e[0;32m\]\h\[\e[0;0m\]:\w$(__git_ps1 "\[\e[0;36m\][%s]\[\e[0;0m\]")$ '

export EDITOR=vim
set noclobber

# set up colors
export CLICOLOR=1
alias ls="ls --color=auto"
alias tmux="tmux -2" # make tmux default to 256 color support

### Virtualenvwrapper setup
export WORKON_HOME=$HOME/.virtualenvs
[[ -s /usr/bin/virtualenvwrapper.sh ]] && source /usr/bin/virtualenvwrapper.sh
## pip settings
# only install into virtual envs
export PIP_REQUIRE_VIRTUALENV=true
# automatically use an activated environment
export PIP_RESPECT_VIRTUALENV=true
# make pip play nice with virtualenvwrapper
export PIP_VIRTUALENV_BASE=$WORKON_HOME
# make pip cache downloaded files
export PIP_DOWNLOAD_CACHE="~/.pip/download-cache"

### git shortcodes
alias g=git
alias greset="git fetch && git reset --hard origin/master"

# search for ruby function definitions
def (){
  PATTERN=$1
  shift
  ack "def (self\.)?$PATTERN" $*
}

refactor (){
  grep -r $1 * | cut -d: -f 1 | uniq | xargs -n 1 sed -i "s/$1/$2/g"
}

dead_defs (){
  ack 'def (self\.)?[\w?!]+' | cut -d ':' -f 3 | perl -ple 's/^\s*def (self\.)?([\w?!]+).*/\2/' | sort | uniq
}

:q (){
  exit
}

alias b="bundle"
alias be="bundle exec"
alias ber="bundle exec rake"
alias mig="bundle exec rake db:migrate db:test:prepare"
alias rs="relevant-tests | specr"
alias rc="bundle exec rails console"
alias cdc="cd ~/causes"
alias r="(cd ~/causes && touch tmp/restart.txt) && (curl -s zamboni.causes.com > /dev/null &)"
alias restart_unicorn="kill -USR2 \`cat /var/run/philotic/pids/unicorn_causes.pid\`"

cdg () {
  bundle show $1 && cd `bundle show $1`
}

function cdp () {
  cd "$(python -c "import os.path as _, ${1}; \
          print _.dirname(_.realpath(${1}.__file__[:-1]))"
     )"
}

alias smtpdebug="python -m smtpd -n -c DebuggingServer localhost:1025"

ssh-reagent () {
 for agent in /tmp/ssh-*/agent.*; do
   echo Trying $agent
   export SSH_AUTH_SOCK=$agent
   if ssh-add -l 2>&1 > /dev/null; then
     echo Found working SSH Agent:
     ssh-add -l
     return
   fi
 done
 echo "Cannot find ssh agent - maybe you should reconnect and forward it?"
}

alias skipt="SKIP_CHECKS=test_history"

servehere () {
  # start a simple http server in the working directory
  # Usage:
  # servehere [port=8000]
  python -m SimpleHTTPServer ${1:-8000}
}

if [ -d $HOME/.rbenv/bin ] ; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# Control the command history
export HISTFILESIZE=10000
export HISTSIZE=10000
export HISTCONTROL=ignoredups:erasedups

# set up solarized-dark dircolors
eval `dircolors ~/.dircolors.ansi-dark`

[[ -s ~/.bash_profile.local ]] && source ~/.bash_profile.local
