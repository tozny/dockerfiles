# Dockerfile written by Eric Mann <eric@tozny.com>
#
# Work derived from official PHP Docker Library:
# Copyright (c) Docker, Inc.
# Copyright (c) 2021 Tozny, LLC

FROM alpine:3.17

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8

# add a simple script that can auto-detect the appropriate JAVA_HOME value
# based on whether the JDK or only the JRE is installed
RUN { \
		echo '#!/bin/sh'; \
		echo 'set -e'; \
		echo; \
		echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
	} > /usr/local/bin/docker-java \
	&& chmod +x /usr/local/bin/docker-java

ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV PATH $PATH:$JAVA_HOME/bin
ENV JAVA_VERSION 8

RUN set -x \
	&& apk add --no-cache \
		openjdk8 \
		libsodium \
		bash \
		coreutils \
		curl \
		openssl \
	&& [ "$JAVA_HOME" = "$(docker-java)" ] \
	&& ln -s /usr/lib/libsodium.so.18 /usr/lib/libsodium.so

ADD import-rds-certs.sh /bin/
RUN import-rds-certs.sh


WORKDIR /data

CMD ["/bin/sh"]
