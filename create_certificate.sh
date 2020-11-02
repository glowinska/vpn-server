#!/bin/bash

cd /etc/ipsec.d/

ipsec pki --gen --type rsa --size 4096 --outform der > private/strongswanKey.der

chmod 600 private/strongswanKey.der

ipsec pki --self --ca --lifetime 3650 --in private/strongswanKey.der --type rsa --dn "C=PL, O=ServerName, CN=ServerIP.pl" --outform der > cacerts/strongswanCert.der

ipsec pki --gen --type rsa --size 4096 --outform der > private/vpnHostKey.der


