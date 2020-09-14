# https://github.com/librespot-org/librespot/blob/master/COMPILING.md
FROM ubuntu:18.04 as librespot_source

RUN apt-get update && apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y \
    build-essential \
    portaudio19-dev \
    libasound2-dev \
    libpulse-dev \
    pkg-config \
    curl \
    git
    
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
RUN git clone https://github.com/librespot-org/librespot.git /src
WORKDIR /src
ENV PATH="/root/.cargo/bin:$PATH"
RUN cargo build \
        --release \
        --no-default-features
# RUN cargo install librespot

# Stage 2 build published image
FROM ubuntu:focal

ENV LIBRESPOT_NAME librespot

## librespot dependencies for run
RUN apt-get update && apt-get install -y \ 
        libportaudio2 \
    && apt-get clean && rm -fR /var/lib/apt/lists

# Copy image built from source
COPY --from=librespot_source \
        /src/target/release/librespot \
        /usr/local/bin/librespot
COPY entrypoint.sh /

# Create user librespot for running librespot
RUN chmod +x /usr/local/bin/librespot && \
    chmod +x entrypoint.sh && \
    groupadd -r librespot && \
    useradd -ms /bin/bash -g librespot librespot

USER librespot

ENV device_name SpotifyConnect

ENTRYPOINT ["/entrypoint.sh"]

