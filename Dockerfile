FROM alpine:latest

LABEL name="default" \
  version="1.0.0" \
  source="https://github.com/madhuakula/docker-security-checker/blob/master/policy/security.rego" \
  summary="Alpine JDK 11 Image." \
  team="THD CNS Team"

RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*
RUN update-ca-certificates
RUN mkdir -p /usr/src/app \
    && addgroup app \
    && adduser -h /usr/src/app -G app -D app \
    && apk add --no-cache wget \
    && apk add --update -u openssl \
    && rm -rf /var/cache/apk/* \
    && apk add --update -u apk-tools \
    && apk add --no-cache tar \
    && apk add --no-cache gzip \
    && openssl version \
    && apk --no-cache add openjdk11 --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community
RUN chown -R app:app /usr/src/app
RUN chmod 755 /usr/src/app 
RUN chmod 777 /opt
### App
WORKDIR /usr/src/app
USER app