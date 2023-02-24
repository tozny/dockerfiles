FROM nginx:alpine

ENV NGINX_CONF=/etc/nginx/conf.d/default.conf
COPY default.conf ${NGINX_CONF}
RUN chgrp 0 ${NGINX_CONF}
RUN chmod g+w ${NGINX_CONF}
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
