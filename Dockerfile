FROM ubuntu:yakkety
MAINTAINER Dan Porter <dpreid@gmail.com>

RUN set -x && \
    apt-get update && apt-get install -y --no-install-recommends \
        chocolate-common && \
    rm -rf /var/lib/apt/lists/*

ENV PATH="/usr/games:${PATH}"

EXPOSE 2342/udp

ENTRYPOINT ["chocolate-server"]
