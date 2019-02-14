#! /bin/sh

# Uses | as delimeter or else sed fails because FQDN contains /, which interferes with default sed delimeter
sed -i "s|REDIRECT_FQDN|$REDIRECT_FQDN|" $NGINX_CONF

exec "$@"
