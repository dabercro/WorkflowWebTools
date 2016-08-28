#!/bin/bash

# Valid options for generating passwords are:
#  -aes128
#  -aes192
#  -aes256

passwordopt=$1

if [ ! -d keys ]
then
    mkdir keys
fi

if [ ! -f keys/privkey.pem ]
then
    openssl genrsa $passwordopt -out keys/privkey.pem 2048
fi

if [ ! -f keys/salt.txt ]
then
    python -mgeneratesalt > keys/salt.txt
fi

openssl req -new -x509 -days 365 -key keys/privkey.pem -out keys/cert.pem

touch keys/valid_email.txt

if [ ! -f keys/config.yml ]
then
    cp ../docs/config.yml keys/.
fi

echo "Do not forget to add valid email domains to your file:"
echo ""
echo " keys/valid_email.txt"
echo ""
echo "and edit the configuration file:"
echo ""
echo " keys/config.yml"
echo ""
