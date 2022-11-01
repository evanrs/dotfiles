#!/bin/sh

clean() {
  # List of targets to match
  targets=(
    adobe
    amazon.sendtokindle
    dropbox
    citrix
    google.keystone
    GoToMeeting
    oracle.java
    skype
    valvesoftware.steamclean
    wasabiclient
    zoom
    teamviewer
    jamf
  )

  # Paths to match targets from
  paths=(
    "/Library/LaunchAgents"
    "/Library/LaunchDaemons"
    "$HOME/Library/LaunchAgents"
    # "$HOME/Library/LaunchDaemons"
  )

  # List of specific services to remove
  services=(
    # com.company.nuisance
  )

  # List of specific files to remove
  files=(
    # /Library/LaunchAgents/nuisance
  )

  # Accumulate services and files for removal and unloading
  for target in ${targets[@]} ; do
    services+=(`launchctl list | grep -i "\.$target\." | awk '{print $3}'`) ;

    for path in ${paths[@]}; do
      path_files=(`ls -a1 "$path" | grep -i "\.$target\."`)
      files+=("${path_files[@]/#/$path/}")
    done
  done

  # Remove services
  for service in ${services[@]}; do
    echo Removing $service
    launchctl remove ${service} ;
  done

  # Unload files
  for file in ${files[@]}; do
    echo Unloading $file
    launchctl unload ${file} > /dev/null 2>&1;
  done

  . "$HOME/.dotfiles/macos/cleanse.sh"
}

disinfect() {
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
    # sudo rm -rf ${file};
  done
}

clean
disinfect
