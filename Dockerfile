FROM ubuntu:18.10

RUN apt-get update && \
    apt-get install -y mingw-w64 curl make \
    libgpgme-dev libassuan-dev libbtrfs-dev libdevmapper-dev pkg-config

COPY --from=golang:1.20.5-buster /usr/local/go/ /usr/local/go/
ENV PATH="/usr/local/go/bin:${PATH}"

WORKDIR skopeo
COPY . .
CMD /bin/bash -c \
    CGO_ENABLED=0 make bin/skopeo.linux.amd64 && \
    CGO_ENABLED=0 make bin/skopeo.linux.arm64

# docker build -f Dockerfile -t skopeo-build .
# docker run -v bin:/skopeo/bin -t skopeo-build
