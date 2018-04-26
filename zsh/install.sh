#!/usr/bin/env zsh
setopt EXTENDED_GLOB

ln -sFfv "${ZDOTDIR:-$HOME}"/.dotfiles/zsh/prezto "${ZDOTDIR:-$HOME}"/.zprezto

for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -sfv "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

chsh -s /bin/zsh
