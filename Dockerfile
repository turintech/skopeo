# FROM ubuntu:18.04
FROM golang:1.20.5-buster
RUN apt-get update && \
    apt-get install -y build-essential curl make \
    libgpgme-dev libassuan-dev libbtrfs-dev libdevmapper-dev pkg-config

# COPY --from=golang:1.20.5-buster /usr/local/go/ /usr/local/go/
# ENV PATH="/usr/local/go/bin:${PATH}"

WORKDIR skopeo
COPY . .
CMD /bin/bash -c \
    make bin/skopeo.linux.amd64 && \
    make bin/skopeo.linux.arm64

# docker build -f Dockerfile -t skopeo-build .
# docker run -v bin:/skopeo/bin -t skopeo-build
