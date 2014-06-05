export PATH=~/bin:$PATH
export EDITOR=vim

# keybindings
bindkey -e

## history
bindkey '^r' history-incremental-search-backward
bindkey "^[[5~" up-line-or-history
bindkey "^[[6~" down-line-or-history

## make search up and down work, so partially type and hit up/down to find relevant stuff
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

bindkey "^[[H" beginning-of-line
bindkey "^[[1~" beginning-of-line
bindkey "^[OH" beginning-of-line
bindkey "^[[F"  end-of-line
bindkey "^[[4~" end-of-line
bindkey "^[OF" end-of-line

# make control+arrow keys jump words
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Make the delete key (or Fn + Delete on the Mac) work instead of outputting a ~
bindkey '^?' backward-delete-char
bindkey "^[[3~" delete-char
bindkey "^[3;5~" delete-char
bindkey "\e[3~" delete-char

# Completion
autoload -U compinit
zmodload -i zsh/complist

# History
if [ -z $HISTFILE ]; then
    HISTFILE=$HOME/.zsh_history
fi
HISTSIZE=10000
SAVEHIST=10000

setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_space
setopt inc_append_history

# when deleting words (^w), stop on backslashes
export WORDCHARS=${WORDCHARS//[\/]}

# make terminal.app play nice with unicode
export LANG=en_US.UTF-8

# only build x86_64 binaries
export ARCHFLAGS="-arch x86_64"

# rmpyc - recursively deletes pyc files below this directory
alias rmpyc="find . -name '*.pyc' -delete"

# start a simple smtp server for debugging
alias smtpdebug="python -m smtpd -n -c DebuggingServer localhost:1025"

### Virtualenvwrapper setup
export WORKON_HOME=$HOME/.virtualenvs
[[ -s /usr/bin/virtualenvwrapper.sh ]] && source /usr/bin/virtualenvwrapper.sh
[[ -s /usr/local/bin/virtualenvwrapper.sh ]] && source /usr/local/bin/virtualenvwrapper.sh

## pip settings
# only install into virtual envs
export PIP_REQUIRE_VIRTUALENV=true
# automatically use an activated environment
export PIP_RESPECT_VIRTUALENV=true
# make pip play nice with virtualenvwrapper
export PIP_VIRTUALENV_BASE=$WORKON_HOME
# make pip cache downloaded files
export PIP_DOWNLOAD_CACHE="~/.pip/download-cache"

### lolcodes
alias rtfm='man'
alias moar='more'
alias donotwant='rm'
alias dowant='cp'
alias gtfo='mv'
alias hai='cd'

# git shortcuts
alias g='git'
alias gpsh='git push origin HEAD:$(git_current_branch)'

# budler shortcuts
alias b='bundle'
alias be='bundle exec'
alias mig="bundle exec rake db:migrate db:test:prepare"

# setup rbenv if installed
if [[ -d $HOME/.rbenv/bin ]]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# search for ruby definitions
def (){
  PATTERN=$1
  shift
  ack "(class|module|def) (self\.)?$PATTERN" $*
}

# jump to bundled gem
cdg () {
  bundle show $1 && cd `bundle show $1`
}

# jump to python package
function cdp () {
  cd "$(python -c "import os.path as _, ${1}; \
      print _.dirname(_.realpath(${1}.__file__[:-1]))"
      )"
}

# reconnect to ssh-agent
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
 echo Cannot find ssh agent - maybe you should reconnect and forward it?
}

# set up colors
autoload colors; colors;
export LSCOLORS="Gxfxcxdxbxegedabagacad"

# set up prompt
setopt prompt_subst

PROMPT='%{$fg[blue]%}%m:%{$fg[magenta]%}${PWD/#$HOME/~}
%{$fg[green]%}%(!.#.$)%{$reset_color%} '

RPROMPT='%{$fg[blue]%}[ %* ]%{$reset_color%}'

# add platform specific overrides
PLATFORM_RC="~/.zshrc.`uname`"
[[ -s $PLATFORM_RC ]] && source $PLATFORM_RC

# add locals
[[ -s ~/.zshrc.local ]] && source ~/.zshrc.local
