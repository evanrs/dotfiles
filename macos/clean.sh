#!/bin/sh

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
)

# Paths to match targets from
paths=(
    "/Library/LaunchAgents"
    "$HOME/Library/LaunchAgents"
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
	services+=(`launchctl list | grep "\.$target\." | awk '{print $3}'`) ;

    for path in ${paths[@]}; do
        path_files=(`ls -a1 "$path" | grep "\.$target\."`)
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
    launchctl unload ${file} ;
done
