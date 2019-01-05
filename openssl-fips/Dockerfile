# From https://github.com/shantanugadgil/fips140-2-haproxy/blob/master/Dockerfile
FROM centos:7 as builder

ENV OPENSSL_VER 1.0.2o
ENV OPENSSL_FIPS_VER 2.0.16

RUN yum -y update
RUN yum install -y gcc wget gpg perl make patch pcre-static pcre-devel zlib-devel curl

RUN wget https://www.openssl.org/source/openssl-fips-${OPENSSL_FIPS_VER}.tar.gz

RUN tar oxvfm openssl-fips-${OPENSSL_FIPS_VER}.tar.gz

# Build the FIPS module according to the instructions at
# https://www.openssl.org/docs/fips/UserGuide-2.0.pdf
RUN cd openssl-fips-${OPENSSL_FIPS_VER} && ./config
RUN cd openssl-fips-${OPENSSL_FIPS_VER} && make
RUN cd openssl-fips-${OPENSSL_FIPS_VER} && make install

# Build the OpenSSL library
RUN wget https://www.openssl.org/source/openssl-${OPENSSL_VER}.tar.gz

RUN tar oxvfm openssl-${OPENSSL_VER}.tar.gz
RUN cd openssl-${OPENSSL_VER} && ./config fips shared --openssldir=/usr/local/ssl --with-fipsdir=/usr/local/ssl/fips-2.0 --with-fipslibdir=/usr/local/ssl/fips-2.0/lib/
RUN cd openssl-${OPENSSL_VER} && make depend
RUN cd openssl-${OPENSSL_VER} && make
RUN cd openssl-${OPENSSL_VER} && make install

RUN find /usr/local/ssl

RUN yum clean all && rm -rf /var/cache/yum

# Inject FIPS Openssl and HAproxy build into rancher load balancer
FROM ubuntu:18.04
COPY --from=builder /usr/local/ssl/ /usr/local/ssl/
ENV OPENSSL_FIPS=1
ENV PATH="/usr/local/ssl/bin/:${PATH}"
