FROM alpine:3.10

RUN apk add --no-cache mysql-client python py-pip curl
RUN pip install awscli

# use docker volume for dump file location
VOLUME /tmp
COPY . /app
WORKDIR /app
ENTRYPOINT [ "/app/run.sh" ]