#! /usr/bin/env zsh

function clo() {
  zparseopts -D -E -A opts \
    -help: h:- \
    -from: f:: \
    -to: t::

  help=$(expr $#opts[--help] + $#opts[-h])
  from=${opts[--from]:-${opts[-f]}}
  to=${opts[--to]:-$opts[-t]}

  # read in arugments, but prefer props
  from=${from:-${1:-}}
  to=${to:-${2:-${1:-}}}

  if (($help)); then
    I=$(echo $0 | sed "s/./ /g")
    print -rC1 -- \
      "$0 [-h|--help]" \
      "$I show this command" \
      "" \
      "$I [-s|--from=<path>]" \
      "$I [-o|--to=<path>]"
    return
  fi

  if [[ $1 == "update" ]]; then;
    echo "this would update the source repo … but that's not happening"
    return;
  fi

  eval src="$(cat .clorc.json | jq -cr ".paths.$from" 2>/dev/null)"
  eval dest=./$to
  if [ -z "$src" ]; then
    echo "Could not find project '$from' in local .clorc.json"
    exit 1
  fi

  set -e

  echo "src: $src" "dest: $dest"

  # clone/cwd
  git clone $src $dest
  cd ./$dest

  # Correct remote to match project
  git remote remove origin
  git remote add origin $(cat $src/.git/config | grep url | awk '{print $3}' | head -n1)

  # link editor preferences
  ln -sFv ../$src/.vscode

  # bootstrap project
  # - ideally expect a root ./bootstrap script
  #
  # but for now lets assume Frontend Core
  yarn install --immutable
  yarn build:packages
}
