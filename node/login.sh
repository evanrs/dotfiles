#!/usr/bin/env bash

if ! [ -e "$HOME/.npmrc" ]; then
  echo "\nAuthenticate your npm account"
  npm login
fi
