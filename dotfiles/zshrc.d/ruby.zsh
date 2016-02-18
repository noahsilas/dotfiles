# Ruby Setup
# setup rbenv if installed
if [[ -d $HOME/.rbenv ]]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# search for ruby definitions
def (){
  PATTERN=$1
  shift
  ack "(class|module|def) (self\.)?$PATTERN" "$@"
}

# jump to bundled gem
cdg () {
  bundle show "$1" && cd "$(bundle show "$1")" || exit
}

# budler shortcuts
alias b='bundle'
alias be='bundle exec'
alias mig="bundle exec rake db:migrate db:test:prepare"

