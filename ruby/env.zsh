#! /usr/bin/env zsh

chruby_path=/opt/homebrew/opt/chruby

if [ -d "$chruby_path" ]; then; else
  chruby_path=/usr/local/opt/chruby;
fi

if [ -d "$chruby_path" ]; then;
  # enable ruby version switching
  source $chruby_path/share/chruby/chruby.sh

  # enable auto-switching of Rubies specified by .ruby-version files
  source $chruby_path/share/chruby/auto.sh
else
  echo chruby not installed;
fi
