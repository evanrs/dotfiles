source "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zshrc"

##
## Here be dragons
##
## (∩ ͡° ͜ʖ ͡°)⊃━☆ﾟ. *
##

autoload -Uz promptinit
promptinit
prompt pure

source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc

eval $(thefuck --alias)
