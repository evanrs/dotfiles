#!/usr/bin/env bash

installed=($(brew list --cask))
dependencies=(
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
  gifrocket
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

brew install 'mas' > dev/null
if [ `mas list` == "" ]; then
  echo "› brew bundle app store apps"
  brew bundle --file=./homebrew/app-store-apps.rb | true
fi
