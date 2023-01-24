#! /usr/bin/env zsh

function sidebar() {
  zparseopts -D -E -A opts \
    -help: h:- \
    -name: n:: \
    -src: s::

  help=$(expr $#opts[--help] + $#opts[-h])
  name=${opts[--name]:-${opts[-f]}}
  src=${opts[--src]:-$opts[-t]}

  # Read in arugments, but prefer props
  name=${name:-${1:-}}
  src=${src:-${2:-.}}

  if (($help)); then
    I=$(echo $0 | sed "s/./ /g")
    print -rC1 -- \
      "$0 [-h|--help]" \
      "$I show this command" \
      "" \
      "$I [-n|--name=<path>]" \
      "$I [-s|--src=<path>]"
    return
  fi

  # transform values
  src="$(realpath $src)"
  name=${name:-"$(basename $src)"}

  {
    mysides add $src "file://$src" 2>&2 1>/dev/null
    echo "$name -> $src"
  } || {
    echo "Something went wrong"
  }

}
