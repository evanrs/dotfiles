function pbd() {
  yarn create next-app $2 --example https://github.com/evanrs/$1 --example-path src
}

#                                                                              #
#    fn. .  .   .     .        .             .                     .           #
#                                                                              #
function gs.() {
  git status .
}

function gpa.() {
  git remote | xargs -L1 git push --all
}

function ip.() {
  zparseopts -D -E -A opts \
    -help: h:- \
    -port: p:: \
    -protocol: t::

  help=$(expr $#opts[--help] + $#opts[-h])
  port=${opts[--port]:-${opts[-p]}}
  protocol=${opts[--protocol]:-$opts[-t]}

  if (($help)); then
    I=$(echo $0 | sed "s/./ /g")
    print -rC1 -- \
      "$0 [-h|--help]" \
      "$I show this command" \
      "" \
      "$0 [-v|--verbose] " \
      "$I [-p|--port=<number>]" \
      "$I [-t|--protocol=<string>]"
    return
  fi

  devip=$(bun x dev-ip)
  value=$(echo $devip | sed "s/'/\"/g" | jq ".[0]" | sed "s/\"//g" | sed "s/^/${protocol:-"http:"}\/\//g")

  if (($#port)); then
    value=$(echo $value | sed "s/\$/\:$port/g" | sed "s/\s|\n//g")
  fi

  echo $value
}

function ip.web() {
  echo $(ip. $@) | xargs -n 1 open -u
}

function ip.ios() {
  echo $(ip. $@) | xargs -n 1 xcrun simctl openurl booted
}

function cmd.copy() {
  # only works in zsh
  echo $(r) | pbcopy
}

function yarn-patch() {
  source=$(yarn patch $1 --json | jq --raw-output .path)
  callback=yarn patch-commit -s $source
  echo $source | xargs -n1 code
  echo $callback | pbcopy
  echo $callback
}
