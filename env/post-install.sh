#!/usr/bin/env bash

source $HOME/.dotfiles/node/env.zsh
pnpm install -g zx

cd $HOME/.dotfiles/env/zxs
pnpm i

# TODO load or prepare zxs linking
# – or leave to zxs own npm scripts
