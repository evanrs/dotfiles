#!/bin/sh

#
# This script configures my Node.js development setup. Note that
# nvm is installed by the Homebrew install script.
#

source ~/.nvm/nvm.sh

if test ! $(which nvm)
then
	echo "Installing a stable version of Node..."
  NVM_PREVIOUS_VERSION=`nvm current`

	# Install the latest stable version of node
	nvm install stable

	# Switch to the installed version
	nvm use stable

  nvm reinstall-packages $NVM_PREVIOUS_VERSION

	# Use the stable version of node by default
	nvm alias default stable
fi

# Login in to npm
npm whoami || npm login

# All `npm install <pkg>` commands will pin to the version that was available at the time you run the command
# npm config set save-exact = true

# Use yarn
# Globally install with npm
# To list globally installed npm packages and version: npm list -g --depth=0
npm install -g yarn

# Does not work with yarn
npm install -g azure-cli

# Some descriptions:
#
# diff-so-fancy — sexy git diffs
# git-recent — Type `git recent` to see your recent local git branches
# git-open — Type `git open` to open the GitHub page or website for a repository
packages=(
    babel-cli
		diff-so-fancy
		flow-bin
		flow-typed
		git-open
		git-recent
		gulp
		http-server
		nodemon
		npm-check
		servedir
		svgo
		webpack
		yo
    node-gyp
		tabtab
    yarn-completions
)

yarn global add "${packages[@]}"
