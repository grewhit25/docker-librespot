FROM alpine:edge

# https://github.com/librespot-org/librespot.git
# https://github.com/kevineye/docker-librespot

WORKDIR /root
# nix 0.10.0 fix; https://github.com/librespot-org/librespot/issues/454
COPY Cargo.toml-upd /tmp/Cargo.toml

RUN apk update && \
    apk add --virtual .build-deps build-base git curl cargo portaudio-dev protobuf-dev pulseaudio-dev && \
    apk upgrade \
    cd /root \
    && git clone https://github.com/librespot-org/librespot.git \
    && cd librespot \
    && cp /tmp/Cargo.toml connect/ \
    && cargo build --jobs 2 --release --no-default-features \
    && mv /root/librespot/target/release/librespot /usr/local/bin \
    && cd / \
    && apk --purge del .build-deps \
    && apk add llvm-libunwind \
    && rm -rf /etc/ssl /var/cache/apk/* /lib/apk/db/* /root/librespot /root/.cargo

USER root

#ENV SPOTIFY_NAME Docker
#ENV SPOTIFY_DEVICE /data/fifo
#
#CMD librespot -n "$SPOTIFY_NAME" -u "$SPOTIFY_USER" -p "$SPOTIFY_PASSWORD" --device "$SPOTIFY_DEVICE"

