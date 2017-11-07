#! /bin/sh

sed -e "s#ECRURL#${ECR_URL}#" haproxy.cfg.template > /usr/local/etc/haproxy/haproxy.cfg.1
sed -e "s#REGISTRYHOST#${REGISTRY_HOST}#" /usr/local/etc/haproxy/haproxy.cfg.1 > /usr/local/etc/haproxy/haproxy.cfg

rsyslogd -f /usr/local/etc/haproxy/rsyslogd.conf

haproxy -f /usr/local/etc/haproxy/haproxy.cfg
