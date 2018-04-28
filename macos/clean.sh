#!/bin/sh

# List of specific services
services=(
	# com.company.nuisance
)

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


for target in ${targets[@]} ; do
	services+=(`launchctl list | grep "\.$target\." | awk '{print $3}'`) ;
done

# for service in ${services[@]} ; do echo "${service}" ; done
for service in ${services[@]} ; do
	echo Removing $service ;
	launchctl remove ${service} ;
done
