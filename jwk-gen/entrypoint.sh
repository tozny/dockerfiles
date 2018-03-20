#! /bin/sh

openssl genrsa -out /tmp/private.pem 2048 >/dev/null 2>&1

node pem-to-jwk.js
