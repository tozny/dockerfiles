#! /bin/sh

# Uses | as delimeter or else sed fails because FQDN contains /, which interferes with default sed delimeter
sed -i "s|REDIRECT_FQDN|$REDIRECT_FQDN|" $NGINX_CONF
sed -i "s|LISTEN_PORT|${LISTEN_PORT:-80}|" $NGINX_CONF
sed -i "s|REDIRECT_CODE|${REDIRECT_CODE:-301}|" $NGINX_CONF

exec "$@"
