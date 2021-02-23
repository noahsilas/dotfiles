# My Dotfiles

## Installing

```bash
git clone git@github.com:noahsilas/dotfiles.git
cd ./dotfiles
./linkup

vim -c PlugInstall

# compile Command-T
cd ~/.vim/plugged/Command-T/ruby/command-t/ext/command-t
ruby extconf.rb
make
```

### MacOS
- Install [Homebrew](https://brew.sh/)

- Run mac specific setup script:
  ```bash
    /usr/bin/env zsh ./macos.sh
  ```

- Add iTerm profile (from `./iterm2-profile.json)`
