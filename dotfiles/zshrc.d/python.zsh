# Python Setup
## Virtualenvwrapper
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

# jump to python package
function cdp () {
  cd "$(python -c "import os.path as _, ${1}; \
      print _.dirname(_.realpath(${1}.__file__[:-1]))"
      )" || exit
}

# rmpyc - recursively deletes pyc files below this directory
alias rmpyc="find . -name '*.pyc' -delete"
