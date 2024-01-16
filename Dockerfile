FROM  golang:1.21.6-bullseye

RUN apt-get update && \
    apt-get install -y mingw-w64 curl make \
    libgpgme-dev libassuan-dev libdevmapper-dev pkg-config libbtrfs-dev

# COPY --from=golang:1.20.5-buster /usr/local/go/ /usr/local/go/
# ENV PATH="/usr/local/go/bin:${PATH}"

WORKDIR skopeo
COPY . .
CMD /bin/bash -c \
    ldd --version && \
    CGO_ENABLED=0 make bin/skopeo.linux.amd64 && \
    CGO_ENABLED=0 make bin/skopeo.linux.arm64

# # docker build -f Dockerfile -t skopeo-build .
# # docker run -v bin:/skopeo/bin -t skopeo-build
