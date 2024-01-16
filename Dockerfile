FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y mingw-w64 curl make \
    libdevmapper-dev libgpgme-dev pkg-config \
    libassuan-dev go-md2man

COPY --from=golang:1.20.5-buster /usr/local/go/ /usr/local/go/
ENV PATH="/usr/local/go/bin:${PATH}"

WORKDIR skopeo
COPY . .
CMD /bin/bash -c \
    make bin/skopeo.linux.amd64 && \
    make bin/skopeo.linux.arm64

# docker build -f Dockerfile -t skopeo-build .
# docker run -v bin:/skopeo/bin -t skopeo-build
