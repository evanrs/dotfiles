#! /usr/bin/env zsh

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
  eval src="$(cat .clorc.json | jq -cr ".paths.$from" 2>/dev/null)"
  if [ -z "$src" ]; then
    echo "Could not find project '$from' in local .clorc.json"
    return;
  fi

  # Collect shared items
  cd $src
    sourceDir=$(pwd)
    editorSettings=$(find . -path */.vscode -not -path */node_modules/*)
  cd -

  # Exit if a step fails
  # set -e

  # Clone
  git clone $src $dest

  # Prepare
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
      git pull --rebase origin $main

    git checkout -b $to

    # Link shared resources: .vscode, caches
    echo $editorSettings | xargs -n1 -I % ln -sFv $sourceDir/% %
    mkdir -p $sourceDir/.yarn/cache
    ln -sFv $src/.yarn/cache .yarn/cache

    # Copy unshared resources: .envrc
    cp $src/.envrc .envrc

    # Bootstrap project
    # - ideally expect a root ./bootstrap script,
    #   but for now we assume Frontend Core
    timeout 15 yarn install --immutable
    if [ $? -eq 124 ]; then
      yarn install --immutable
    fi
    # or .ghostrc for commands to run
    yarn build:packages

    # TODO: incrementing parameter inputs
    # count=$(echo $prevCountOrWhatevs)
    # echo $(expr $count + 1) >> '.envrc'

    # TODO: use default editor from:
    #       project setting, .ghostrc shared setting, or env
    # TODO: use editor selection to copy editor specifc preferences
}
