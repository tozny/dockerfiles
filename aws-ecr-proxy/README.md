Proxy requests from you.customdomain.com to the less-pretty ECR url like `12314141.dkr.ecr.us-west-2.amazonaws.com`.

You only need to set one environment variable: `ECR_URL` and start the service. It is a basic nginx proxy.


## How this works

HAProxy does not support logging to STDOUT/STDIN. The `/var/log/haproxy/*` files are symlinked to PID 1's STDOUT/STDIN. All HAProxy logs are sent to `rsyslog` running on port 8514. `rsyslog` then outputs the log to the haproxy logs, which are in turn output to STDOUT/STDIN. This is picked up by `docker logs <container>`. It's complicated because HAProxy doesn't support STDOUT logging, and [Docker haproxy build doesn't support it either](https://github.com/dockerfile/haproxy/issues/3).
