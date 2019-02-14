# Redirector

Sends HTTP 301 redirect during any request to this container. Useful for starting domain name changes of web services.

# Use Example

```
docker run -it --rm \
  -p 8080:80 \
  -e REDIRECT_FQDN=https://tozny.com \
  tozny/redirector
```
