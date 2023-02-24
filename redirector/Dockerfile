FROM nginx:alpine

ENV NGINX_CONF=/etc/nginx/conf.d/default.conf
COPY default.conf ${NGINX_CONF}

# Allow _group_ root to edit nginx conf for OpenShift compatibility
# Must be whole directory, because of sed temp files
RUN chgrp -R 0 $(dirname ${NGINX_CONF})
RUN chmod -R g+w $(dirname ${NGINX_CONF})

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
