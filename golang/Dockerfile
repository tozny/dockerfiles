# Use official Golang image with defined version and os, generally alpine with version
FROM golang:1.25.12-alpine3.24
RUN apk add --no-cache openssh git
RUN apk add --upgrade libcrypto3 libssl3 git busybox ssl_client
