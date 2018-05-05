#!/usr/bin/env bash

# Set node env
NODE_VERSION=v10.0.0

export NVM_DIR="$HOME/.nvm"
if ! [ -e "$NVM_DIR" ]; then
	mkdir "$NVM_DIR"
fi

# Load nvm from brew
. "/usr/local/opt/nvm/nvm.sh"

# Configure node version
if [ "$(nvm version current)" == "none" ]; then
	cp -f "$ZSH/node/nvm/*" "$HOME/.nvm/"
	nvm install $NODE_VERSION --latest-npm
	nvm alias default $NODE_VERSION
fi

nvm use --delete-prefix v10.0.0 --silent
