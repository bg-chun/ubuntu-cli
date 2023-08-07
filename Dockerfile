ARG KUBECTL_VERSION="1.25.8-00"
FROM golang:1.19-alpine AS builder

RUN apk add --no-cache alpine-sdk
COPY ./ /src
WORKDIR /src
RUN make build

FROM ubuntu:lunar
ARG KUBECTL_VERSION

#install essential packages
RUN apt update && \
    apt install -y --no-install-recommends \
    ca-certificates curl apt-transport-https gpg && \
    rm -rf /var/lib/apt/lists/*

#install latest kubectl
RUN curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /etc/apt/keyrings/kubernetes-archive-keyring.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list && \
    apt update && apt install -y --no-install-recommends kubectl=${KUBECTL_VERSION} && \
    rm -rf /var/lib/apt/lists/*

#install devops utils
RUN apt update && \
    apt install -y --no-install-recommends \
    python3-openstackclient git wget vim dnsutils telnet iputils-ping && \
    rm -rf /var/lib/apt/lists/*

#configure default shell as bash
SHELL ["/bin/bash", "-c"]
