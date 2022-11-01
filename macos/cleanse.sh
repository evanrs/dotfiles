#!/bin/sh

# iterate by new line
IFS=$'\n'

# List of targets to match
targets=(
  citrix
  GoToMeeting
  zoom
  jamf
)

# Paths to match targets from
paths=(
  "/Library/Application Support"
  "/Library/LaunchAgents"
  "/Library/LaunchDaemons"
  "$HOME/Library/Application Support"
  "$HOME/Library/LaunchAgents"
  # "$HOME/Library/LaunchDaemons"
)

# List of specific files to remove
files=(
  # /Library/LaunchAgents/nuisance
)

# Accumulate services and files for removal and unloading
for target in ${targets[@]} ; do
  for path in ${paths[@]}; do
    path_files=(`ls -a1 "$path" | grep -i "$target"`)
    for file in ${path_files[@]}; do
      files+=(
        "${file[@]/#/$path/}"
      )
    done
  done
done

# Remove files
for file in ${files[@]}; do
  echo Removing $file
  sudo rm -rf ${file};
done
