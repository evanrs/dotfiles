function zlist_peek() {
  echo $1
  # printf %s\\n "${"$@"[-1]}"
}

function zlist_push() {
  echo "$@"
}

function zlist_pop() {
  args=$@
  zlist_peek $@
  unset 'args[-1]'
}

# • • • • • • • • • • • • • • • • • • • • • • • • •
# TODO: create a alias that operates on a list name
# zlpush some_list_name $argument_to_append
# • • • • • • • • • • • • • • • • • • • • • • • • •

# alias -g zlpeek='echo $($1)[0]'
# alias -g zlpeek='echo hai'

alias -g zlpush='
  $args=$@
  $list_name=zlist_peek
  echo $listname
'

function zlpop() {
  args="$@"
  peek $args
  unset 'args[-1]'
}
