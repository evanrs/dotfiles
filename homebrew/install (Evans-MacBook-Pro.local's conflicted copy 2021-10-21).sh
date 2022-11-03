#!/usr/bin/env bash

echo "› brew bundle command line tools"
brew bundle --file=./homebrew/command-line-tools.rb

echo "› brew bundle fonts"
brew bundle --file=./homebrew/fonts.rb || true

echo "› brew install app"
installed=($(brew list --cask))
dependencies=(
  dropbox
  alfred
  keybase
  spotify
  firefox
  google-chrome
  "homebrew/cask-versions/google-chrome-canary"
  safari-technology-preview
  charles
  ngrok
  postman
  iterm2
  hyper
  sequel-pro
  android-studio
  insomnia
  virtualbox
  docker
  google-cloud-sdk
  atom
  sublime-text
  visual-studio-code
  sketch
  kaleidoscope # compare files
  # gifrocket
  vlc
  slack
  geekbench
)

for dependency in ${dependencies[@]}
do
  if [[ ! " ${installed[*]} " =~ " ${dependency} " ]]; then
      brew install -f $dependency
  fi
done

brew install 'mas' &> dev/null
if [ `mas list` == "" ]; then
  echo "› brew bundle app store apps"
  brew bundle --file=./homebrew/app-store-apps.rb | true
fi


# tucker.godek