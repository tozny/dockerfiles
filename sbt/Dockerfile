# This Dockerfile has two required ARGs to determine which base image
# to use for the JDK and which sbt version to install.

FROM eclipse-temurin:11-jdk-jammy

ARG SBT_VERSION=1.10.7

# Install sbt
RUN \
  mkdir /working/ && \
  cd /working/ && \
  curl -L -o sbt-$SBT_VERSION.deb https://repo.scala-sbt.org/scalasbt/debian/sbt-$SBT_VERSION.deb && \
  dpkg -i sbt-$SBT_VERSION.deb && \
  rm sbt-$SBT_VERSION.deb && \
  apt-get update && \
  apt-get install sbt && \
  cd && \
  rm -r /working/ && \
  sbt --version

# Include libsodium
RUN apt-get update && apt-get install -y --no-install-recommends \
  libsodium23 \
  && rm -rf /var/lib/apt/lists/*
