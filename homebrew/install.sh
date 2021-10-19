#!/usr/bin/env bash

echo "› brew bundle command line tools"
brew bundle --file=./homebrew/command-line-tools.rb

echo "› brew bundle fonts"
brew bundle --file=./homebrew/fonts.rb | true
