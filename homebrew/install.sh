#!/usr/bin/env bash

source $HOME/.dotfiles/homebrew/env.zsh

echo "› brew bundle command line tools"
brew bundle --file=$HOME/.dotfiles/homebrew/command-line-tools.rb

echo "› brew bundle fonts"
brew bundle --file=$HOME/.dotfiles/homebrew/fonts.rb || true

echo "› brew install app"
installed=($(brew list --cask))
dependencies=(
  alfred
  keybase
  spotify
  firefox
  google-chrome
  # "homebrew/cask-versions/google-chrome-canary"
  # safari-technology-preview
  # charles
  ngrok
  postman
  iterm2
  # hyper
  # sequel-pro
  android-studio
  # insomnia
  # virtualbox
  docker
  google-cloud-sdk
  notion
  sublime-text
  visual-studio-code
  sketch
  figma
  # kaleidoscope # compare files
  # gifrocket
  # vlc
  slack
  geekbench

  # … it's an app for some reason?
  miniconda
)

for dependency in ${dependencies[@]}; do
  if [[ ! " ${installed[*]} " =~ " ${dependency} " ]]; then
    brew install -f $dependency
  fi
  # TODO: uninstall unlisted casks, make this the source of truth?
done

brew install mas 2>/dev/null
echo "› brew bundle app store apps"
brew bundle --file=$HOME/.dotfiles/homebrew/app-store-apps.rb | true
