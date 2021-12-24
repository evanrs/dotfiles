#!/usr/bin/env bash

echo "> set git configuration"
git config --global init.defaultBranch main
git config --global diff.noprefix true

echo "> install git assistants"
# TODO figure out where the heck this is
# pnpm install -g git-info
