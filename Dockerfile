FROM alpine:3.17.2

COPY init /init
COPY run_tunnel /run_tunnel

RUN apk update; apk add --no-cache bash; apk add --no-cache openssh-client; chmod +x /init; chmod +x /run_tunnel


CMD ["/bin/bash","./init"]

EXPOSE 1-65535