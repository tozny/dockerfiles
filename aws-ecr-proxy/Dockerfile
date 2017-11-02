FROM haproxy:1.7-alpine
COPY haproxy.cfg.template /
COPY rsyslog.conf /usr/local/etc/haproxy/rsyslogd.conf
RUN apk add --no-cache ca-certificates rsyslog
COPY entrypoint.sh /entrypoint.sh

# From: https://github.com/rancher/lb-controller/blob/6463125410d9e57229e229922f59d061704d4f5b/package/haproxy/Dockerfile
RUN mkdir /var/log/haproxy
RUN touch /var/log/haproxy/traffic /var/log/haproxy/events /var/log/haproxy/errors
RUN ln -sf /proc/1/fd/1 /var/log/haproxy/events
RUN ln -sf /proc/1/fd/1 /var/log/haproxy/traffic
RUN ln -sf /proc/1/fd/2 /var/log/haproxy/errors

# So we do not write to the COW filesystem
VOLUME /var/log/haproxy

ENTRYPOINT ["/entrypoint.sh"]
