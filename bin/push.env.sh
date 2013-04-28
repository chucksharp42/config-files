#!/bin/sh

to_user=$to_user
host=$1

# Usage check
[ -z "$host" ] && { echo "usage: $0 <hostname>"; exit 255; }

# install env
scp -r $HOME/{.bash_profile,.exrc,.rpmmacros,.inputrc,bin} $to_user@$host:/home/$to_user/

