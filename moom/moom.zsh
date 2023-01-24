modulePath=$(realpath ~/.dotfiles/moom)
defaultFilename="moom.settings"

function moomsave() {
  zparseopts -D -E -A opts \
    -help: h:- \
    -name: n::

  help=$(expr $#opts[--help] + $#opts[-h])
  # Read in arugments, but prefer props
  name=${opts[--name]:-${opts[-f]}}
  name=${name:-${1:-}}
  name=${name:-$defaultFilename}

  if (($help)); then
    I=$(echo $0 | sed "s/./ /g")
    print -rC1 -- \
      "$0 [-h|--help]" \
      "$I show this command" \
      "" \
      "$I [-s|--name=<path>]" \
      return
  fi

  filename=$(realpath "$modulePath/$name.plist")
  defaults export com.manytricks.Moom $filename
}

function moomload() {
  zparseopts -D -E -A opts \
    -help: h:- \
    -name: n::

  help=$(expr $#opts[--help] + $#opts[-h])
  # Read in arugments, but prefer props
  name=${opts[--name]:-${opts[-f]}}
  name=${name:-${1:-}}
  name=${name:-$defaultFilename}

  if (($help)); then
    I=$(echo $0 | sed "s/./ /g")
    print -rC1 -- \
      "$0 [-h|--help]" \
      "$I show this command" \
      "" \
      "$I [-n|--name=<path>]" \
      return
  fi

  filename=$(realpath "$modulePath/$name.plist")
  defaults import com.manytricks.Moom $filename
}
