#! /bin/sh

set -e

if [ -z "${AWS_ACCESS_KEY_ID}" ]; then
  echo "Warning: You did not set the AWS_ACCESS_KEY_ID environment variable."
  exit 1
fi

if [ -z "${AWS_SECRET_ACCESS_KEY}" ]; then
  echo "Warning: You did not set the AWS_SECRET_ACCESS_KEY environment variable."
  exit 1
fi

if [ -z "${S3_BUCKET}" ]; then
  echo "You need to set the S3_BUCKET environment variable."
  exit 1
fi

if [ -z "${MYSQL_HOST}" ]; then
  echo "You need to set the MYSQL_HOST environment variable."
  exit 1
fi

if [ -z "${MYSQL_USER}" ]; then
  echo "You need to set the MYSQL_USER environment variable."
  exit 1
fi

if [ -z "${MYSQL_PASSWORD}" ]; then
  echo "You need to set the MYSQL_PASSWORD environment variable or link to a container named MYSQL."
  exit 1
fi

if [ -z "${AWS_DEFAULT_REGION}" ]; then
  echo "Warning: You did not set the AWS_DEFAULT_REGION environment variable."
  exit 1
fi

if [ -z "${AWS_DEFAULT_REGION}" ]; then
  echo "Warning: You did not set the AWS_DEFAULT_REGION environment variable."
  exit 1
fi

if [ -z "${S3_FILENAME_PREFIX}" ]; then
  echo "Warning: You did not set the S3_FILENAME_PREFIX environment variable."
  exit 1
fi


MYSQLDUMP_OPTIONS="--quote-names --quick --add-drop-table --add-locks --allow-keywords --disable-keys --extended-insert --single-transaction --create-options --comments --net_buffer_length=16384"
MYSQLDUMP_DATABASE="--all-databases"
MYSQL_PORT="3306"
MYSQL_HOST_OPTS="-h $MYSQL_HOST -P $MYSQL_PORT -u$MYSQL_USER -p$MYSQL_PASSWORD"
DUMP_START_TIME=$(date +"%Y-%m-%dT%H%M%SZ")
S3_PREFIX=$(date +"%Y-%m-%d")

copy_s3 () {
  SRC_FILE=$1
  DEST_FILE=$2

  echo "Uploading ${DEST_FILE} on S3..."

  cat $SRC_FILE | aws $AWS_ARGS s3 $S3_ARGS cp - s3://$S3_BUCKET/$S3_PREFIX/$DEST_FILE

  if [ $? != 0 ]; then
    >&2 echo "Error uploading ${DEST_FILE} on S3"
  fi

  rm $SRC_FILE
}

echo "Creating dump for ${MYSQLDUMP_DATABASE} from ${MYSQL_HOST}..."

DUMP_FILE="/tmp/dump.sql.gz"
mysqldump $MYSQL_HOST_OPTS $MYSQLDUMP_OPTIONS $MYSQLDUMP_DATABASE | gzip > $DUMP_FILE

if [ $? == 0 ]; then
    S3_FILE="${S3_FILENAME_PREFIX}-${DUMP_START_TIME}.dump.sql.gz"
    copy_s3 $DUMP_FILE $S3_FILE
else
    >&2 echo "Error creating dump of all databases"
fi

echo "SQL backup finished"