# Redirector

Sends HTTP 301 redirect during any request to this container. Useful for starting domain name changes of web services.

# Use Examples

With defaults:
```
docker run -it --rm \
  -p 8080:80 \
  -e REDIRECT_FQDN=https://tozny.com \
  tozny/redirector
```

Listen on alternate port, and serve temporary redirect:
```
docker run -it --rm \
  -p 8080:8080 \
  -e LISTEN_PORT=8080 \
  -e REDIRECT_CODE=302 \
  -e REDIRECT_FQDN=https://tozny.com \
  tozny/redirector
```