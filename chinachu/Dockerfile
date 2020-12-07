FROM node:10-alpine

ENV DOCKER="YES"
ARG REPOSITORY="git://github.com/Chinachu/Chinachu.git"
ARG BRANCH="gamma"

ARG WORK_DIR="/usr/local/chinachu"

#node container default value
ARG USER_NAME="node"
ARG NODE_ENV="production"

RUN set -x \
        && apk upgrade --update \
        && apk add \
                bash \
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
        && mkdir -p ${WORK_DIR} 

# add dumb-init
ENV INIT_VER="1.2.2"
ENV INIT_SUM="37f2c1f0372a45554f1b89924fbb134fc24c3756efaedf11e07f599494e0eff9"
ADD https://github.com/Yelp/dumb-init/releases/download/v${INIT_VER}/dumb-init_${INIT_VER}_amd64 /dumb-init
RUN echo "$INIT_SUM  dumb-init" | sha256sum -c - && \
      chmod +x /dumb-init

# clone and install chinachu
RUN git clone ${REPOSITORY} ${WORK_DIR} \
        && chown -R ${USER_NAME} ${WORK_DIR} \
        && cd ${WORK_DIR} \
        && git checkout ${BRANCH} \
        && echo 1 | sudo -u ${USER_NAME} ./chinachu installer \
#       && sudo -u ${USER_NAME} ./chinachu service operator initscript | tee /tmp/chinachu-operator \
#       && sudo -u ${USER_NAME} ./chinachu service wui initscript | tee /tmp/chinachu-wui \
        && sudo -u ${USER_NAME} mv config.sample.json config.json \
        && sudo -u ${USER_NAME} mv rules.sample.json rules.json \
        && sudo -u ${USER_NAME} mkdir log \
        && sudo -u ${USER_NAME} mkdir recorded \
        && sudo -u ${USER_NAME} mkdir data \
        \
        #&& chown root. /tmp/chinachu-operator /tmp/chinachu-wui \
#       && chmod u+x /tmp/chinachu-operator /tmp/chinachu-wui \
#       && mv /tmp/chinachu-operator /etc/init.d/ \
#       && mv /tmp/chinachu-wui /etc/init.d/ \
        \
        # cleaning
        && cd / \
        && npm cache verify \
        && apk del --purge .build-deps \
        && rm -rf /tmp/* \
        && rm -rf /var/cache/apk/*

        # forward request and error logs to docker log collector
        #&& ln -sf /dev/stdout ${WORK_DIR}/log/operator \
        #&& ln -sf /dev/stdout ${WORK_DIR}/log/scheduler \
        #&& ln -sf /dev/stdout ${WORK_DIR}/log/wui

# these directories must be mounted and be persistent.
# /usr/local/chinachu/config.json
# /usr/local/chinachu/rules.json
# /usr/local/chinachu/data
# /usr/local/chinachu/recorded

COPY ./docker-entrypoint.sh /
RUN chmod +rx /docker-entrypoint.sh

WORKDIR ${WORK_DIR}
EXPOSE 10772 20772 5353

USER ${USER_NAME}

ENTRYPOINT ["/dumb-init", "--"]
