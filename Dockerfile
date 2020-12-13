FROM alpine:latest
RUN apk update \
  && apk add git openssh --no-cache
COPY entrypoint.sh /usr/src/app/
COPY ssh_config/ssh_config /etc/ssh/
RUN chmod 755 /usr/src/app/entrypoint.sh

ENTRYPOINT ["/bin/sh"]
CMD ["/usr/src/app/entrypoint.sh"]
