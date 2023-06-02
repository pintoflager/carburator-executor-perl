#!/usr/bin/env sh

role="$1"

# App installation tasks on a client node. Runs first
if [ "$role" = 'client' ]; then
    carburator print terminal info "Executing install script on a client"
fi

# App installation tasks on remote server node.
if [ "$role" = 'server' ]; then
    carburator print terminal info "Executing install script on a server"
fi

# Test if we already have perl
if ! carburator has program perl; then
    carburator print terminal error \
        "Missing required program perl. Trying to install..."
else
    carburator print terminal success "Perl found from the $role"
    exit 0
fi

# TODO: Untested below
if carburator has program apt; then
    apt-get -y update
    apt-get -y install perl

elif carburator has program pacman; then
    pacman update
    pacman -Suy perl

elif carburator has program yum; then
    yum makecache --refresh
    yum install perl

elif carburator has program dnf; then
    dnf makecache --refresh
    dnf -y install perl-core

else
    carburator print terminal error \
        "Unable to detect package manager from client node linux"
    exit 120
fi
