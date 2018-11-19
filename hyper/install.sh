#!/bin/sh
set -e

ln -sFn "${ZROOTDIR:-$HOME}/.dotfiles/hyper/hyper.js" "${ZROOTDIR:-$HOME}/.hyper.js"

mkdir -p "${ZROOTDIR:-$HOME}/.hyper_plugins"
ln -sFn "${ZROOTDIR:-$HOME}/.dotfiles/hyper/plugins" "${ZROOTDIR:-$HOME}/.hyper_plugins/local"
