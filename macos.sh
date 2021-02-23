#!/usr/bin/env zsh

brew tap homebrew/cask-fonts
brew install --cask font-inconsolata-dz-for-powerline
brew install --cask meslo-for-powerline

brew install ruby
brew install vim
brew install tmux
brew install the_silver_searcher
brew install jq
brew install fzf
brew install --cask iterm2
brew install --cask hammerspoon
brew install --cask karabiner-elements

brew install --cask 1password
brew install --cask slack
brew install --cask google-chrome
brew install --cask dash

# Many settings via https://gist.github.com/bradp/bea76b16d3325f5c47d4

# Move dock to left side of screen
defaults write com.apple.dock orientation left

# Setting Dock to auto-hide and removing the auto-hiding delay
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0

# Speeding up Mission Control animations and grouping windows by application
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock "expose-group-by-app" -bool true

# Restart modified services
killall Dock
killall Finder
