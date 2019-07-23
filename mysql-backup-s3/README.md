# mysql-backup-s3

Adapted (and largely modified) from https://github.com/schickling/dockerfiles/blob/master/mysql-backup-s3/Dockerfile

Backup MySQL to S3 (supports periodic backups)

## Environment variables

- `MYSQLDUMP_OPTIONS` mysqldump options (default: --quote-names --quick --add-drop-table --add-locks --allow-keywords --disable-keys --extended-insert --single-transaction --create-options --comments --net_buffer_length=16384)
- `MYSQLDUMP_DATABASE` list of databases you want to backup *required*
- `MYSQL_HOST` the mysql host *required*
- `MYSQL_PORT` the mysql port (default: 3306)
- `MYSQL_USER` the mysql user *required*
- `MYSQL_PASSWORD` the mysql password *required*
- `AWS_ACCESS_KEY_ID` your AWS access key *required*
- `AWS_SECRET_ACCESS_KEY` your AWS secret key *required*
- `S3_BUCKET` your AWS S3 bucket path *required*
- `AWS_DEFAULT_REGION` the AWS S3 bucket region *required*
- `S3_S3V4` set to `yes` to enable AWS Signature Version 4, required for [minio](https://minio.io) servers (default: no)
- `SCHEDULE` backup schedule time, see explainations below
- `S3_ARGS` arguments to use in S3 command, such as `--storage-class=GLACIER`
- `AWS_ARGS` arguments to pass to the aws part of the CLI, such as `aws --endpoint=url=<endpoint>` where `--endpoint=url=<endpoint>` is `AWS_ARGS`
- `S3_FILENAME_PREFIX` prefix to append to s3 filename *required*

### Automatic Periodic Backups

You can additionally set the `SCHEDULE` environment variable like `-e SCHEDULE="@daily"` to run the backup automatically.

More information about the scheduling can be found [here](http://godoc.org/github.com/robfig/cron#hdr-Predefined_schedules).
