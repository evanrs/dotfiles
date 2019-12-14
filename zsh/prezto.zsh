source "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zshrc"

##
## Here be dragons
##
## (∩ ͡° ͜ʖ ͡°)⊃━☆ﾟ. *
##

tabs -2

autoload -Uz promptinit
promptinit
prompt pure

eval $(thefuck --alias)
