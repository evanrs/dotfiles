export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# TODO a less fragile link to global modules when available …
export PNPM_GLOBAL_BIN=$(dirname $(volta which node))
export PATH="$PNPM_GLOBAL_BIN:$PATH"
