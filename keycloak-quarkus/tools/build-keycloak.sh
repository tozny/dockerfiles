#!/bin/bash -e

###########################
# Build/download Keycloak #
###########################

if [ "$GIT_REPO" != "" ]; then
    if [ "$GIT_BRANCH" == "" ]; then
        GIT_BRANCH="master"
    fi

    # Install Git
    microdnf install -y git

    # Install JDK 11 for quarkus build
    #microdnf install java-11-openjdk-devel
    JAVA_HOME="$(dirname $(dirname $(readlink -f $(which java))))"
    export JAVA_HOME

    # Clone repository
    git clone --depth 1 https://github.com/$GIT_REPO.git -b $GIT_BRANCH /opt/quarkus/keycloak-source

    # Build
    cd /opt/quarkus/keycloak-source

    MASTER_HEAD=`git log -n1 --format="%H"`
    echo "Keycloak from [build]: $GIT_REPO/$GIT_BRANCH/commit/$MASTER_HEAD"

    ./mvnw -pl quarkus/deployment,quarkus/dist -am -DskipTests clean install

    cd /opt/quarkus
    tar xfz /opt/quarkus/keycloak-source/quarkus/dist/target/keycloak-*.tar.gz
    echo "hello"

    # Remove temporary files
    rm -rf /opt/quarkus/maven
    rm -rf /opt/quarkus/keycloak-source
    rm -rf $HOME/.m2/repository


    mv /opt/quarkus/keycloak-* /opt/keycloak
    chown -R 1000:0 /opt/keycloak
else
    echo "Keycloak from [download]: $KEYCLOAK_DIST"

    cd /opt/quarkus/
    curl -L $KEYCLOAK_DIST | tar zx
    mv /opt/quarkus/keycloak-* /opt/keycloak
fi
