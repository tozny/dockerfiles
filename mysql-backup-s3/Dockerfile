FROM alpine:3.10

RUN apk add --no-cache mysql-client python py-pip curl
RUN pip install awscli
RUN curl -L https://github.com/odise/go-cron/releases/download/v0.0.7/go-cron-linux.gz | zcat > /usr/local/bin/go-cron
RUN chmod u+x /usr/local/bin/go-cron

# use docker volume for dump file location
VOLUME /tmp
COPY . /app
WORKDIR /app
ENTRYPOINT [ "/app/run.sh" ]