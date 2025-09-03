FROM registry.access.redhat.com/ubi9 as ubi-micro-build
ENV LANG en_US.UTF-8
ENV KEYCLOAK_VERSION 26.1.4
ENV JDBC_POSTGRES_VERSION 42.2.5

ENV LANG en_US.UTF-8

ARG GIT_REPO=tozny/keycloak
ARG GIT_BRANCH=PLAT-1669-Add-Mfa-Capability
#ARG GIT_BRANCH=WR-595-Keycloak-Upgrade-${KEYCLOAK_VERSION}

USER root

RUN yum update -y && yum install -y git openssl tar which java-21-openjdk-devel glibc-langpack-en findutils && yum clean all

# Clone repository
RUN git clone --depth 1 https://github.com/$GIT_REPO.git -b $GIT_BRANCH /opt/keycloak-source

# Build
WORKDIR /opt/keycloak-source

RUN ./mvnw -pl quarkus/deployment,quarkus/dist -am -DskipTests clean install

WORKDIR /opt/quarkus

RUN tar xfz /opt/keycloak-source/quarkus/dist/target/keycloak-*.tar.gz

FROM registry.access.redhat.com/ubi9 as ubi-null

ADD ubi-null.sh /tmp/
RUN bash /tmp/ubi-null.sh java-21-openjdk-headless glibc-langpack-en findutils

FROM registry.access.redhat.com/ubi9
ENV LANG en_US.UTF-8

# Flag for determining app is running in container
ENV KC_RUN_IN_CONTAINER true

COPY --from=ubi-null /tmp/null/rootfs/ /
COPY --from=ubi-micro-build --chown=1000:0 /opt/quarkus/keycloak-* /opt/keycloak

RUN echo "keycloak:x:0:root" >> /etc/group && \
    echo "keycloak:x:1000:0:keycloak user:/opt/keycloak:/sbin/nologin" >> /etc/passwd

USER 1000
EXPOSE 8080
EXPOSE 8443
EXPOSE 9000

ENTRYPOINT [ "/opt/keycloak/bin/kc.sh" ]
