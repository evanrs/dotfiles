#!/bin/sh

#
# This script configures my Node.js development setup. Note that
# nvm is installed by the Homebrew install script.
#
# Also, I would highly reccomend not installing your Node.js build
# tools, e.g., Grunt, gulp, WebPack, or whatever you use, globally.
# Instead, install these as local devDepdencies on a project-by-project
# basis. Most Node CLIs can be run locally by using the executable file in
# "./node_modules/.bin". For example:
#
#     ./node_modules/.bin/webpack --config webpack.local.config.js
#

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

# All `npm install <pkg>` commands will pin to the version that was available at the time you run the command
# npm config set save-exact = true

# Use yarn


# Globally install with npm
# To list globally installed npm packages and version: npm list -g --depth=0
npm install -g yarn

# Some descriptions:
#
# diff-so-fancy — sexy git diffs
# git-recent — Type `git recent` to see your recent local git branches
# git-open — Type `git open` to open the GitHub page or website for a repository
packages=(
    azure-cli
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
)

yarn global add "${packages[@]}"
