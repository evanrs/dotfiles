# TODO:
# - add per directory history
#   https://github.com/jimhester/per-directory-history
# - check local/global storage
# - extend with path aliases
# - extend with custom checks, so a repo test can be used

source "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zshrc"

##
## Here be dragons
##
## (∩ ͡° ͜ʖ ͡°)⊃━☆ﾟ. *
##

function shortcake() {
  echo "Opening https://kapeli.com/cheat_sheets/Prezto.docset/Contents/Resources/Documents/index"
  open https://kapeli.com/cheat_sheets/Prezto.docset/Contents/Resources/Documents/index
}

tabs -2

eval $(thefuck --alias)

# TODO figure out where the heck this is
# git-info on

echo -e "🍰 have some \e[95m\e[3m\e[1mshortcake\e[0m\n"
