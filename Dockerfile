FROM webhippie/alpine:latest
ENTRYPOINT [""]

RUN apk update && \
  apk upgrade && \
  apk add jsonnet && \
  rm -rf /var/cache/apk/*
