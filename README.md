# My Dotfiles

## Installing

```bash
git clone git@github.com:noah256/dotfiles.git
cd ./dotfiles
git submodule update --init
./linkup
```

## Adding a vim submodule
```bash
NAME=vim-airline
CLONE_URL=https://github.com/bling/vim-airline.git
git submodule add --name ${NAME} ${CLONE_URL} dotfiles/vim/bundle/${NAME}
```
