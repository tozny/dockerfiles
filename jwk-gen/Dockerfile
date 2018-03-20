FROM node:alpine

RUN apk add --no-cache openssl && \
  npm install rsa-pem-to-jwk

WORKDIR /app/
COPY . /app/

ENTRYPOINT /app/entrypoint.sh
