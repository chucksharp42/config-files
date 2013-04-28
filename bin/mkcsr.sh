#!/bin/sh


DIR=/tmp

C=
ST=
L=
O=
OU=
CN="$1"
emailAddress=
csr="${CN}.csr"
key="${CN}.key"

echodo() {
     echo "${@}"
     (${@})
     }



echo "Create key/csr for ${CN}? (Y to continue)"
read ans
[ "$ans" != "Y" -a "$ans" != "y" ] && exit


mkdir $CN
cd $CN

openssl req -new -newkey rsa:2048 -keyout $key \
     -nodes -out $csr <<EOF
${C}
${ST}
${L}
${O}
${OU}
${CN}
${emailAddress}
.
.
EOF
echo ""

[ -f ${csr} ] && echodo openssl req -text -noout -in ${csr}
echo ""

ls -l $csr $key
