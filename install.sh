git clone git@github.com:noahsilas/dotfiles.git ~/dotfiles
cd ~/dotfiles && ./linkup
vim +'PlugInstall --sync' +qall &> /dev/null
