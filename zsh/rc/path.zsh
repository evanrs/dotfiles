typeset -U config_files
config_files=($ZSH/*/*.zsh)

print_events=${PRINT_LOAD_EVENTS:-true}

# load the path files
for file in ${(M)config_files:#*/path.zsh}
do
  if [ $print_events = true ]
  then
    echo "Adding to path $file"
  fi

  source $file
done
