if [[ -d ~/.nodenv/bin ]]; then
  export PATH="$HOME/.nodenv/bin:$PATH"
fi

if type nodenv > /dev/null; then
    eval "$(nodenv init -)"
fi
