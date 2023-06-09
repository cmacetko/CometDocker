FROM alpine:latest
LABEL maintainer="cmacetko@gmail.com"
LABEL version="1.0.1"

# Enviornment Variables
ARG COMETD_TARBALL="cometd-23.3.6.linux_amd64.tar.xz"

# Install Comet Dependencies
RUN apk update && apk add \
#	libcap2-bin \
	ca-certificates \
	curl \
	dbus \
	tzdata \
	jq \
	xz

# Copy and extract CometBackup server tarball
COPY cometbackup/$COMETD_TARBALL /tmp/$COMETD_TARBALL
RUN mkdir -p /opt/cometd/
RUN tar x -Jf /tmp/$COMETD_TARBALL -C /opt/cometd/
RUN rm -rf /tmp/$COMETD_TARBALL

# Copy the shell script
COPY cometd.sh /cometd.sh

VOLUME /opt/cometd/

ENTRYPOINT ["/cometd.sh"]

HEALTHCHECK CMD \
	curl -fs http://localhost:8060

EXPOSE 8060
