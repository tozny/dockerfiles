FROM registry.access.redhat.com/ubi8-minimal as ubi-micro-build
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

RUN microdnf update -y && microdnf install -y --nodocs git glibc-langpack-en gzip hostname java-11-openjdk-devel openssl tar which && microdnf clean all

# Clone repository
RUN git clone --depth 1 https://github.com/$GIT_REPO.git -b $GIT_BRANCH /opt/keycloak-source

# Build
WORKDIR /opt/keycloak-source

RUN ./mvnw -e -X -f ./quarkus/pom.xml clean install -DskipTestsuite -DskipExamples -DskipTests

WORKDIR /opt/quarkus

RUN tar xfz /opt/keycloak-source/quarkus/dist/target/keycloak-*.tar.gz

FROM registry.access.redhat.com/ubi8-minimal

ENV LANG en_US.UTF-8

COPY --from=ubi-micro-build --chown=1000:0 /opt/quarkus/keycloak-* /opt/keycloak
RUN microdnf update -y && \
    microdnf install -y --nodocs java-11-openjdk-headless glibc-langpack-en && microdnf clean all && rm -rf /var/cache/yum/* && \
    echo "keycloak:x:0:root" >> /etc/group && \
    echo "keycloak:x:1000:0:keycloak user:/opt/keycloak:/sbin/nologin" >> /etc/passwd

USER 1000
EXPOSE 8080
EXPOSE 8443
EXPOSE 9000

ENTRYPOINT [ "/opt/keycloak/bin/kc.sh" ]
