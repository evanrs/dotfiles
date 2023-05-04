#! /usr/bin/env zsh

alias 'main.ts'="ts-node --swc --require @tsconfig-paths/register"

npmDevModules=(@types/node prettier typescript)
npmDevTesting=(@types/jest @types/node eslint-plugin-testing-library jest jest-watch-typeahead ts-jest typescript msw)
npmDevTestingReact=(@types/react @types/react-dom @testing-library/dom @testing-library/react @testing-library/user-event @testing-library/react-hooks)

function pb() {
  args="$@"

  unset 'args[-1]'
}

function pb-dev() {
  cdo ~/projects/patternbuffer/dev
}

function pb-ready() {
  cdo ~/projects/patternbuffer/ready/$@
}

function quit() {
  pkill -x "Google Chrome"
  pkill -x Slack
  pkill -x zoom.us
  pkill -x Figma
  pkill -x Miro
  pkill -x "Okta Verify"
}

# zstyle ':patternbuffer:*:*:pb-*:*' \
#   all-files \
#   completer _extensions _complete _approximate \
#   menu select

# function _comp_pb_ready {
#   COMPREPLY=($(compgen -d /home/evan/projects/patternbuffer/"$2" | sed -r "s:\ :\\+:g"))
#   COMPREPLY=("${COMPREPLY[@]#/home/evan/projects/patternbuffer/}")

#   if [[ ${#COMPREPLY[@]} -eq 1 ]]; then
#     COMPREPLY=("${COMPREPLY[@]}/")
#   fi
# }
# # complete -o nospace -F _comp_pb_ready pb-ready

# function mcd {
#   local path=$(sed 's/+/\ /g' <<<$@)
#   if [ ! -e "$path" ]; then
#     read -p "'$path' does not exist and will be created (Y[Enter]/N): " confirmation
#     case "$confirmation" in
#     [!yY]) return ;;
#     esac
#   fi
#   mkdir -p "$path"
#   cd "$path"
# }
