#!/bin/sh

# --skip-setup defers to properties set in node/env.zsh
curl https://get.volta.sh | bash -s -- --skip-setup
source $HOME/.dotfiles/node/env.zsh

# set default node version
volta install node

# remove corepack assets
# npm uninstall -gf corepack &>/dev/null
# bin=$(dirname $(which npm))
# rm -rf "$bin/../lib/node_modules/corepack"
# for executable in yarn pnpm pnpx; do
#   rm -f "$bin/$executable" &>/dev/null
# done

# use corepack to integrate yarn and pnpm
# npm install -g corepack

# install dotfiles node dependencies
# pnpm --prefix ~/.dotfiles install

$HOME/.dotfiles/node/login.sh
