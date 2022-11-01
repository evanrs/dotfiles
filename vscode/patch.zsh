#! /usr/bin/env zsh

# https://stackoverflow.com/a/67746753

VSCODE_PATH=/Applications/Visual\ Studio\ Code
VSCODE_PATCH_PATH=resources/app/extensions/node_modules/typescript/lib/tsserver.js

echo $VSCODE_PATH_path

# patch /typescript/lib/tsserver.js
# at around line 12797:
#     ts.defaultMaximumTruncationLength = 800
