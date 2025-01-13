FROM registry.access.redhat.com/ubi8-minimal
ENV KEYCLOAK_VERSION 19.0.2
ENV JDBC_POSTGRES_VERSION 42.2.5

# ENV LAUNCH_JBOSS_IN_BACKGROUND 1
# ENV PROXY_ADDRESS_FORWARDING false
# ENV JBOSS_HOME /opt/jboss/keycloak
ENV LANG en_US.UTF-8

ARG GIT_REPO=tozny/keycloak
ARG GIT_BRANCH=WR-595-Keycloak-Upgrade-${KEYCLOAK_VERSION}
ARG KEYCLOAK_DIST=https://downloads.jboss.org/keycloak/$KEYCLOAK_VERSION/keycloak-$KEYCLOAK_VERSION.tar.gz

USER root

RUN microdnf update -y && microdnf install -y glibc-langpack-en gzip hostname java-11-openjdk-devel openssl tar which && microdnf clean all

ADD tools /opt/quarkus/tools
RUN /opt/quarkus/tools/build-keycloak.sh
