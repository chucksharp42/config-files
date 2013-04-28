#!/bin/sh

key_file="/home/csharp/.ssh/gd.pub"
to_user=csharp
[ -n "$2" ] && to_user=$2

HOMEDIR=/home/$to_user
HOSTDIR=$HOME/.env.hosts
KEYDIR=$HOSTDIR/keys

ssh $to_user@$1 '
mkdir -p $HOME/.ssh; chmod 700 .ssh;
grep -q "csharp@T1WSDV-CSHARP" ~/.ssh/authorized_keys 2>/dev/null || 
echo "'"`cat $keyfile`"'" >> ~/.ssh/authorized_keys;
chmod 600 ~/.ssh/authorized_keys
'

# To doc that this is installed
if [ "$?" == "0" ]; then
    [ -d $KEYDIR ] || mkdir -p $KEYDIR
    touch $KEYDIR/$1
fi

