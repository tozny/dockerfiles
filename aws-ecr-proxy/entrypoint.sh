#!/bin/sh
sed -e "s#ECRURL#${ECR_URL}#" nginx.conf.template > /etc/nginx/nginx.conf
nginx -g "daemon off;"
