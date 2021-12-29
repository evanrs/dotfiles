#! /usr/bin/env zsh

# set -o extendedglob

function cdo() {
  for fullpath in "$@"
  do
    if [ -d "$fullpath" ]; then;
      cd $fullpath
      if [[ -n *.code-workspace(#qN) ]] then;
        open $fullpath/*.code-workspace
      elif [[ -n *.workspace(#qN) ]] then;
        cdo $fullpath/*.workspace
      else
        code $fullpath
      fi
    elif [ -a $fullpath ]; then;
      echo "implement file opening for $fullpath"
      basepath=$fullpath:h
      code $fullpath
      cd $basepath
    fi
  done
}

function cdco() {
  folder="."
  gitfolder=".git"
  root="."
  main=;
  branch=;

  if [ $# -eq 0 ]; then;
    echo "Usage: cdco :path :branch?"
    exit 0
  fi

  if [[ -d "$1" ]]; then;
    folder="$1"
  elif [ -z $1 ]; then;
    branch=$1
  fi;

  if [[ -d "$2" ]]; then;
    folder="$2"
    cdo($2)
  elif [ -z $2 ]; then;
    branch=$2
  fi;

  # cd to given folder
  cd $folder

  root=$(groot)
  main=$(gmain)
  cdo $root
  gco $main
  git pull


  if [ -z "$branch" ]; then;
    # if directory
    # if [[ -d "$2" ]]; then;
    #   cdo($1)
    # fi;

  else;

  fi

  # return to requested folder
  cd $folder
}

groot() {
  git=$([ -d .git ] && echo .git || git rev-parse --git-dir > /dev/null 2>&1)
# folder=$(echo $folder | xargs)
  result="$([ -d .git ] && echo .git || git rev-parse --git-dir > /dev/null 2>&1)"
  length=$(echo ${#folder})
  echo $length
  if [ ${#folder} -gt 0 ]; then;
    echo "a wild repo appears";
  else;
    echo "sorry better luck next repo";
  fi;
}

function gmn () {
    $arg1=echo $1 | xargs
    origin=${arg1:-origin}
    echo \"$origin\"

    git fetch --all;
    output=$(git remote show $origin | sed -n '/HEAD branch/s/.*: //p')

    # TODO:
    # - get last line, or last line -1
    # - strip: line breaks, other white space
    main=$(echo $output | xargs | tail -n1)

    echo $main
}

# git main pull origin
function gmpo () {
  if [ $# -eq 0 ]; then;
    echo "Usage: gmpo :path? :remote?"
    exit 0
  fi

  _wd=$(cwd)
  folder="."
  cd $folder
  remote=${1:-origin}
  branch=$(gmn)

  if [[ -d "$1" ]]; then;
    folder="$1"
  elif [ -z $1 ]; then;
    branch=$1
  fi;

  folder="."
  gitfolder=".git"
  root="."
  main=;
  branch=;

  previous=$(pwd)

  root=$(groot)

  main=$(gmain)
  cdo $root
  gco $main
  git pull
}

function resolveCodeArgs() {
  if [ $# -eq 0 ]; then;
    echo "\nUsage"
    echo "\tresolveCodeArgs :path :branch?\n"
    exit 1
  fi

  folder="unknown"
  branch="unknown"

  if [[ -d "$1" ]]; then;
    folder="$1"
  elif [ -z $1 ]; then;
    branch=$1
  fi;

  if [[ -d "$2" ]]; then;
    folder="$2"
  elif [ -z $2 ]; then;
    branch=$2
  fi;

  echo \t"resolveCodeArgs $folder:path? $branch:branch?"\n
}
