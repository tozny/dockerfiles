#! /bin/sh

set -e

if [ "${S3_S3V4}" = "yes" ]; then
    aws configure set default.s3.signature_version s3v4
fi

if [ -z "${SCHEDULE}" ]; then
  sh /app/backup.sh
else
  echo "$SCHEDULE /bin/sh /app/backup.sh" | crontab - && crond -f -L /dev/stdout
fi