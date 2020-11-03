#!/bin/bash

cd /etc/ipsec.d/

ipsec pki --gen --type rsa --size 4096 --outform der > private/strongswanKey.der

chmod 600 private/strongswanKey.der

ipsec pki --self --ca --lifetime 3650 --in private/strongswanKey.der --type rsa --dn "C=PL, O=ServerName, CN=ServerIP.pl" --outform der > cacerts/strongswanCert.der

ipsec pki --gen --type rsa --size 4096 --outform der > private/vpnHostKey.der

chmod 600 private/vpnHostKey.der

ipsec pki --pub --in private/vpnHostKey.der --type rsa | ipsec pki --issue --lifetime 3650 --cacert cacerts/strongswanCert.der -cakey private/strongswanKey.der --dn "C=PL, O=ServerName, CN=ServerIP.pl" --san @ServerIP.pl -flag serverAuth --flag ikeIntermediate --outform der > certs/vpnHostCert.der

openssl x509 -inform DER -in cacerts/strongswanCert.der -out cacerts/strongswanCert.pem -outform PEM
