# Local build wrapper around the official BirdNET-Go image.
# This makes the stack fully self-contained for balena builds
# (balena runs `docker build` on this Dockerfile instead of pulling
# a prebuilt image), while reusing upstream's published multi-arch
# (amd64 + arm64) image as the runtime base.

# Pin to the upstream release; bump when BirdNET-Go releases a new version.
ARG BIRDNET_GO_VERSION=v0.6.4
FROM ghcr.io/tphakala/birdnet-go:${BIRDNET_GO_VERSION}

# Metadata
LABEL io.balena.arch="amd64 arm64" \
      org.opencontainers.image.title="BirdNET-Go for balenaOS" \
      org.opencontainers.image.description="Realtime bird sound recognition (BirdNET-Go) packaged for balenaOS" \
      org.opencontainers.image.source="https://github.com/matrover/balena-birdnet-go" \
      org.opencontainers.image.licenses="CC-BY-NC-SA-4.0"

# BirdNET-Go upstream defaults (ENTRYPOINT /usr/bin/birdnet-go, CMD realtime,
# volumes /config + /data, port 8080) are inherited unchanged.
