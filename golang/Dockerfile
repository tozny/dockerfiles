# Use official Golang image with defined version and os, generally alpine with version
FROM golang:1.21.5-alpine3.18 
RUN apk add --no-cache openssh git
RUN apk add --upgrade libcrypto3 libssl3 git
ENV GO111MODULE=on
