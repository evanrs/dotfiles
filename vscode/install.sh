#!/bin/sh

set -e

source="${ZROOTDIR:-$HOME}/.dotfiles/vscode/user"
target="${ZROOTDIR:-$HOME}/Library/Application Support/Code/User"

rm -rf "$target"
mkdir -p "$target"

for path in snippets workspaceStorage settings.json keybindings.json; do
  ln -snFv "$source/$path" "$target/$path"
done

