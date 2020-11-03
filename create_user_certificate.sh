#!/bin/bash

IMIE=$1 NAZWISKO=$2

cd /etc/ipsec.d/

ipsec pki --gen --type rsa --size 2048 --outform pem > private/"$IMIE$NAZWISKO"_Key.pem

chmod 600 private/"$IMIE$NAZWISKO"_Key.pem

ipsec pki --pub --in private/"$IMIE$NAZWISKO"_Key.pem --type rsa | ipsec pki --issue --lifetime 730 --cacert cacerts/ca-cert.pem --cakey private/ca-key.pem --dn "C=PL, O=NAME, CN=$IMIE.$NAZWISKO@domain.pl" --outform pem > certs/"$IMIE$NAZWISKO"_Cert.pem

openssl pkcs12 -export -inkey private/"$IMIE$NAZWISKO"_Key.pem -in certs/"$IMIE$NAZWISKO"_Cert.pem -name "Certyfikat - $IMIE $NAZWISKO" -certfile cacerts/ca-cert.pem -caname "10.215.121.200" -out p12/"$IMIE$NAZWISKO".p12

ipsec rereadsecrets
