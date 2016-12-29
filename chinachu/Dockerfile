FROM alpine:3.4
MAINTAINER h-mineta <h-mineta@0nyx.net>

ARG REPOSITORY="git://github.com/Chinachu/Chinachu.git"
ARG BRANCH="master"

RUN set -x \
	&& apk upgrade --update \
	&& apk add \
		bash \
		'nodejs>=6.2.0' \
		coreutils \
		curl \
		procps \
		ca-certificates \
	\
	&& apk add --virtual .build-deps \
		git \
		make \
		gcc \
		g++ \
		autoconf \
		automake \
		wget \
		curl \
		sudo \
		tar \
		xz \
		libc-dev \
		musl-dev \
		eudev-dev \
		libevent-dev \
	\
	&& adduser -D -u 99 -h /usr/local/chinachu chinachu \
	&& mkdir -p /usr/local/chinachu \
	&& git clone ${REPOSITORY} /usr/local/chinachu \
	&& chown -R chinachu:chinachu /usr/local/chinachu \
	&& cd /usr/local/chinachu \
	&& git checkout ${BRANCH} \
	&& echo 1 | sudo -u chinachu ./chinachu installer \
	&& ./chinachu service operator  initscript | sudo -u chinachu tee /tmp/chinachu-operator \
	&& ./chinachu service wui initscript | sudo -u chinachu tee /tmp/chinachu-wui \
	&& sudo -u chinachu mkdir log \
	\
	&& chown root. /tmp/chinachu-operator /tmp/chinachu-wui \
	&& chmod u+x /tmp/chinachu-operator /tmp/chinachu-wui \
	&& mv /tmp/chinachu-operator /etc/init.d/ \
	&& mv /tmp/chinachu-wui /etc/init.d/ \
	\
	# cleaning
	&& cd / \
	&& apk del --purge .build-deps \
	&& rm -rf /tmp/* \
	&& rm -rf /var/cache/apk/*

	# forward request and error logs to docker log collector
	#&& ln -sf /dev/stdout /usr/local/chinachu/log/operator \
	#&& ln -sf /dev/stdout /usr/local/chinachu/log/scheduler \
	#&& ln -sf /dev/stdout /usr/local/chinachu/log/wui

WORKDIR /usr/local/chinachu
COPY services.sh /usr/local/bin
COPY config.sample.json /usr/local/chinachu/config.sample.json

CMD ["/usr/local/bin/services.sh"]
EXPOSE 10772 5353
