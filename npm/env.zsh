# TODO a less fragile link to global modules when available …
export PNPM_GLOBAL_BIN=`dirname \`volta which node\``
export PATH="$PNPM_GLOBAL_BIN:$PATH"

function npm-preview() {
  npm pack && tar -xvzf *.tgz && rm -rf package *.tgz
}
