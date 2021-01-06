#!/usr/bin/env bash

# --skip-setup defers to properties set in node/env.zsh
curl https://get.volta.sh | bash -s -- --skip-setup

volta install node
