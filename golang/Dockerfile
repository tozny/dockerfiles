# Use official Golang image with defined version and os, generally alpine with version
FROM golang:1.24.6-alpine3.22
RUN apk add --no-cache openssh git
RUN apk add --upgrade libcrypto3 libssl3 git busybox ssl_client
