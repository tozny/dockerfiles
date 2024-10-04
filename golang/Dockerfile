# Use official Golang image with defined version and os, generally alpine with version
FROM golang:1.22.8-alpine3.19
RUN apk add --no-cache openssh git
RUN apk add --upgrade libcrypto3 libssl3 git busybox ssl_client 
ENV GO111MODULE=on
