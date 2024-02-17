# ### wasmd ###
FROM cosmwasm/wasmd:v0.50.0 as wasmd

### rust-optimizer ###
FROM cosmwasm/rust-optimizer:0.50.0 as rust-optimizer

# ### kujirad ###
FROM golang:1.20.8-bullseye AS kujirad

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends git make cmake gcc \
    && git clone https://github.com/Team-Kujira/core $HOME/kujira-core \
    && cd $HOME/kujira-core \
    && git checkout v0.9.3-1 \
    && make install

# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.245.0/containers/rust/.devcontainer/base.Dockerfile

# [Choice] Debian OS version (use bullseye on local arm64/Apple Silicon): buster, bullseye
# ARG VARIANT="bullseye"
FROM mcr.microsoft.com/devcontainers/rust:1-bullseye

COPY --from=wasmd /usr/bin/wasmd /usr/local/bin/wasmd
COPY --from=wasmd /opt/* /opt/
COPY --from=kujirad /go/bin/kujirad /usr/local/bin/kujirad
COPY --from=kujirad /go/pkg/mod/github.com/\!cosm\!wasm/wasmvm@v*/internal/api/libwasmvm.x86_64.so /usr/lib/

# Install additional packages.
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends curl jq \
    && sudo rm -rf /var/lib/apt/lists/*

RUN rustup update stable \
    && rustup target add wasm32-unknown-unknown

RUN cargo install cargo-run-script cargo-tarpaulin