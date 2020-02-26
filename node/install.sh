#!/usr/bin/env bash

# Set node env
NODE_VERSION=v13.3.0

export NVM_DIR="$HOME/.nvm"
if ! [ -e "$NVM_DIR" ]; then
	mkdir "$NVM_DIR"
fi

ln -sfv ./default-packages $NVM_DIR

# Load nvm from brew
. "/usr/local/opt/nvm/nvm.sh"

# Configure node version
if [ "$(nvm version current)" == "none" ]; then
	cp -f "$ZSH/node/nvm/*" "$HOME/.nvm/"
	nvm install $NODE_VERSION --latest-npm
	nvm alias default $NODE_VERSION
fi
