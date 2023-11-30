#!/bin/sh

set -e

source="${ZROOTDIR:-$HOME}/.dotfiles/vscode/user"
target="${ZROOTDIR:-$HOME}/Library/Application Support/Code/User"

# rm -rf "$target"
# mkdir -p "$target"

# linkedPaths="snippets workspaceStorage settings.json keybindings.json"
# linkedPaths=""
# for path in $linkedPaths; do
#   ln -snFv "$source/$path" "$target/$path"
# done
