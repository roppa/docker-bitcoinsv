FROM debian:stretch-slim

RUN set -ex \
  && apt-get update \
  && apt-get install -qq --no-install-recommends ca-certificates dirmngr gosu gpg wget \
  && rm -rf /var/lib/apt/lists/*

ENV BITCOIN_VERSION 0.1.0
ENV BITCOIN_URL https://github.com/bitcoin-sv/bitcoin-sv/releases/download/v0.1.0/bitcoin-sv-0.1.0-x86_64-linux-gnu.tar.gz
ENV BITCOIN_SHA256 bb4a8049698bb6723526e1bd457a7cfdb919eac491ee3c3b563c6c159ad278e3

# install bitcoin binaries
RUN set -ex \
  && cd /tmp \
  && wget -qO bitcoin.tar.gz "$BITCOIN_URL" \
  && echo "$BITCOIN_SHA256 bitcoin.tar.gz" | sha256sum -c - \
  && tar -xzvf bitcoin.tar.gz -C /usr/local --strip-components=1 --exclude=*-qt \
  && rm -rf /tmp/*

ENTRYPOINT ["bitcoind", "-regtest",  "-printtoconsole"]
