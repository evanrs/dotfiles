#!/usr/bin/env bash

# Login in to npm
if ! [ -e "$HOME/.npmrc" ]; then
	npm login
fi
