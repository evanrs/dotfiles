#!/bin/sh
set -e

defaults write com.googlecode.iterm2 PrefsCustomFolder -string "${ZROOTDIR:-$HOME}/.dotfiles/iterm2"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -int 1

echo "Linking ${ZROOTDIR:-$HOME}/.dotfiles/iterm2/profiles to ${ZROOTDIR:-$HOME}/Library/Application Support/iTerm2/DynamicProfiles"

mkdir -p "${ZROOTDIR:-$HOME}/Library/Application Support/iTerm2/"
rm -rf "${ZROOTDIR:-$HOME}/Library/Application Support/iTerm2/DynamicProfiles"

# ln -sfF "${ZROOTDIR:-$HOME}/.dotfiles/iterm2/profiles" "${ZROOTDIR:-$HOME}/Library/Application\ Support/iTerm2/DynamicProfiles"
