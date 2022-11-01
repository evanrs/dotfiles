# TODO: add terminal command hook to suggest matching shortcuts

function gatus() {
  git status $@
}

function gi() {
  curl -sLw "\n" https://www.toptal.com/developers/gitignore/api/\$@
}


function gup () {
  git pull origin $@
}

function gph () {
  git push origin HEAD $@
}

function gpb () {
  git push origin "HEAD:$(git-branch-current 2> /dev/null)"
}

function gpsu () {
  git push --set-upstream origin "$(git-branch-current 2> /dev/null)"
}

function grm () {
  owd=$(pwd)
  while [ $# -gt 0 ]; do

    ## -a/-o for single bracket and/or
    # is it a real file or folder? then:
    if [ -z $1 ]; then
      path=$1

      # navigate to repo by path
      # cd $path

      # are we in the same git repo?
      # repo=$(get_repo_root)
      # cd $repo
      # name=$(basename `git rev-parse --show-toplevel`)

      # are the path and repo effectively equal?
      # ERROR:
      # echo "a file must be specified for $name"

      # is it known to git? then:
      # git rm --cached $path

      # should it be moved to storage?
      # move to storage and update path
      # path=$storage_path

      # should it be moved to trash?
      # trash -F $path
    fi

  done

  cd $owd
}

export function git-clear-branches () {
  git branch -r | egrep -v -f /dev/fd/0  <(git branch -vv | grep origin) | xargs git branch -d
}
