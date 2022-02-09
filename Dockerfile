FROM s6on/alpine:3.15
LABEL maintainer="Julio Gutierrez julio.guti+nordlynx@pm.me"

COPY patch/ /tmp/patch
RUN apk add --no-cache -U wireguard-tools curl jq patch && \
    patch --verbose -p0 < /tmp/patch/wg-quick.patch && \
    apk del --purge patch && \
    rm -rf /tmp/* && \
    mkdir -p /etc/wireguard
COPY root/ /

# don't need to build modules
RUN rm /etc/cont-init.d/30-module
