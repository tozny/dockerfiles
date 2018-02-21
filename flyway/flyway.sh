#!/bin/sh -x

JAVA_CMD="$JAVA_HOME/bin/java"
JAVA_ARGS="-Djava.security.egd=file:/dev/../dev/urandom"

DB_DRIVER=${DB_DRIVER:-"mysql"}
DB_HOST=${DB_HOST:-"localhost"}
DB_PORT=${DB_PORT:-"3306"}

INSTALL_DIR=$(dirname $0)

FLYWAY_ARGS=""
[[ -n "$DB_USER" ]] && FLYWAY_ARGS="${FLYWAY_ARGS} -user=${DB_USER}"
[[ -n "$DB_PASSWORD" ]] && FLYWAY_ARGS="${FLYWAY_ARGS} -password=${DB_PASSWORD}"


if [[ -n "$DB_URL" ]]; then
  FLYWAY_ARGS="${FLYWAY_ARGS} -url=${DB_URL}"
elif [[ -n "$DB_DATABASE" ]]; then
  FLYWAY_ARGS="${FLYWAY_ARGS} -url=jdbc:${DB_DRIVER}://${DB_HOST}:${DB_PORT}/${DB_DATABASE}"
fi

"$JAVA_CMD" "$JAVA_ARGS" -cp "${INSTALL_DIR}/drivers/*:${INSTALL_DIR}/lib/*" org.flywaydb.commandline.Main ${FLYWAY_ARGS} "$@"
