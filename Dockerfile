FROM ghcr.io/dockhippie/alpine:3.22@sha256:29332ffd57d5b3922d93a7e0d47484f5da7a963fc8dfd7654ec10a48bf36a20f
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
