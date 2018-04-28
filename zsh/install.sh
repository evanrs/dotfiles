#!/usr/bin/env zsh

if ! [ -e "${ZDOTDIR:-$HOME}/.zprezto" ]
then
  echo "Cloning prezto into  ${ZDOTDIR:-$HOME}/.zprezto"
  git clone --recursive https://github.com/evanrs/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
fi

setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^(zshrc|README.md)(.N); do
  ln -sfv "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

ln -sfv "$ZSH/zsh/zshrc.symlink" "${ZDOTDIR:-$HOME}/.zshrc"

if [ $SHELL != '/bin/zsh' ]
then
  echo "Setting /bin/zsh as default shell"
  chsh -s /bin/zsh
fi
