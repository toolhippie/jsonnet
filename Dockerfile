FROM ghcr.io/dockhippie/alpine:3.23@sha256:c2218a341d02631f8fe99633a9daef146324b9a0b8a1269c2410446f04034319
ENTRYPOINT [""]

# renovate: datasource=github-releases depName=jsonnet-bundler/jsonnet-bundler
ENV JSONNET_BUNDLER_VERSION=0.6.0

ARG TARGETARCH

RUN apk update && \
  apk upgrade && \
  apk add jsonnet && \
  case "${TARGETARCH}" in \
		'amd64') \
			curl -sSLo /usr/bin/jb https://github.com/jsonnet-bundler/jsonnet-bundler/releases/download/v${JSONNET_BUNDLER_VERSION}/jb-linux-amd64; \
			;; \
		'arm64') \
			curl -sSLo /usr/bin/jb https://github.com/jsonnet-bundler/jsonnet-bundler/releases/download/v${JSONNET_BUNDLER_VERSION}/jb-linux-arm64; \
			;; \
		'arm') \
			curl -sSLo /usr/bin/jb https://github.com/jsonnet-bundler/jsonnet-bundler/releases/download/v${JSONNET_BUNDLER_VERSION}/jb-linux-arm; \
			;; \
		*) echo >&2 "error: unsupported architecture '${TARGETARCH}'"; exit 1 ;; \
	esac && \
  chmod +x /usr/bin/jb && \
  rm -rf /var/cache/apk/*
