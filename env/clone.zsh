#! /usr/bin/env zsh

# optional project mods
#  — reset yarn, check cache, non immutable
#  — apply patches to the codebase (by file sha)
#    ex: always needing to enable debugging,
#        or not rendering a component

# when creating a project source, copy all the
# .vscode folders and maintain folder structure
# find . -path */.vscode -not -path ./node_modules/* | xargs -n1 -I % cp -r % ../.fc/%


function clone() {
  zparseopts -D -E -A opts \
    -help: h:- \
    -from: f:: \
    -to: t::

  help=$(expr $#opts[--help] + $#opts[-h])
  from=${opts[--from]:-${opts[-f]}}
  to=${opts[--to]:-$opts[-t]}
  # TODO: convert to props with defaults including .ghostrc
    main=main
    pull=0
    base=./
    delimiter=:

  # Read in arugments, but prefer props
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

  eval dest=./$from:$(echo $to | sed -r "s/[^A-Za-z0-9-]/$delimiter/g")
  eval src="$(cat .ghostrc.json | jq -cr ".projects.$from" 2>/dev/null)"
  if [ -z "$src" ]; then
    echo "Could not find project '$from' in local .clorc.json"
    return;
  fi

  # Collect shared items
  attn Collect shared items
  cd $src
    sourceDir=$(pwd)
    editorSettings=$(find . -path */.vscode -not -path */node_modules/*)
  cd -

  # Exit if a step fails
  # set -e

  # Clone
  attn Clone
  git clone $src $dest

  # Prepare
  attn Prepare
  cd ./$dest
    # Correct remote to match project
    git remote remove origin
    git remote add origin $(cat $src/.git/config | grep url | awk '{print $3}' | head -n1)

    # Change to default branch
    # TODO: use --main or clonerc.main
    # TODO: use --branch to branch from
      # git checkout $main

    # Pull latest updates
    # TODO: if --pull or clonerc.pull are truthy
      # git pull --rebase origin $main

    git fetch origin $to >>/dev/null
    git checkout $to >>/dev/null
    git checkout -b $to >/dev/null

    # We always pull, this is not configurable …
    git pull --rebase --set-upstream origin $to || echo "::: no remote branch, not updating :::"

    # Share resoures
    attn Share Resources
    # Link shared resources: .vscode, caches
    # TODO: use default editor from:
    #       project setting, .ghostrc shared setting, or env
    # TODO: use editor selection to copy editor specifc preferences
    #   - share editor settings
    echo $editorSettings | xargs -n1 -I % ln -sFv $sourceDir/% %
    #   - share cache
    mkdir -p $sourceDir/.yarn/cache
    ln -sFv $src/.yarn/cache .yarn/cache
    #   - clone environment: .envrc …
    cp $src/.envrc .envrc
    direnv allow
    eval "$(direnv export zsh)"

    # Apply project mods:
    attn Modify
    # - custom port mod
    echo export PORT=`portplz` >> .envrc
    # TODO: incrementing parameter inputs
    # - incrementing global mod
    # port=$(echo $portMax)
    # echo $(expr $portMax + 1) >> .envrc

    # Bootstrap project
    attn Bootstrap
    for ((i=0,x=1; i<10 && x; i+=1)); do
      # this would be handled in their bootstrap script
      bootstrap;
      x=$(( $? == 124 ))
    done
}

function attn () {
  echo
  echo
  echo "$@"
  sleep 1
  echo
}

function bootstrap() {
  timeout 120 yarn install --immutable

  # or .ghostrc for commands to run
  yarn build:packages
}

function portplz() {
  a="$(random)$(random)"
  # b="$(random)$(random)"
  # c=" ($a % 10) + ($b % 10) "
  # out=$(eval expr $c)
  # out=`eval expr  ($a % 10) + ($b % 10)`

  # TODO: configurable base port
  echo "$(expr $a + 4000)"
}

function rand__test__() {
  for (( x=1; x > 0; x+=1 )); do;
    echo "$(rand)"
    source ~/.zshrc `random`
    # v=($(rand) $(rand) $(rand) $(rand) $(rand) $(rand) $(rand) $(rand))
    # echo $v | awk '{ printf "%-4s %-4s %-4s %-4s %-4s %-4s %-4s %-4s\n", $1, $2, $3, $4, $5, $6, $7, $8}'

    sleep 4;
    rand__test__
  done;
}
