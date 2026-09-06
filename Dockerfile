# Local build wrapper around the official BirdNET-Go image.
# This makes the stack fully self-contained for balena builds
# (balena runs `docker build` on this Dockerfile instead of pulling
# a prebuilt image), while reusing upstream's published multi-arch
# (amd64 + arm64) image as the runtime base.

# Digest-pinned snapshot of upstream `latest` (verified to resolve on GHCR;
# multi-arch: linux/amd64 + linux/arm64). A digest is immutable, so balena
# builds are reproducible. Bump when BirdNET-Go publishes a new release.
ARG BIRDNET_GO_VERSION=sha256:233b94f1d3b27b261ec8d997364db0cb953f3e3b3362a89e9e22ad4a589143d6
FROM ghcr.io/tphakala/birdnet-go@${BIRDNET_GO_VERSION}

# Metadata
LABEL io.balena.arch="amd64 arm64" \
      org.opencontainers.image.title="BirdNET-Go for balenaOS" \
      org.opencontainers.image.description="Realtime bird sound recognition (BirdNET-Go) packaged for balenaOS" \
      org.opencontainers.image.source="https://github.com/matrover/balena-birdnet-go" \
      org.opencontainers.image.licenses="CC-BY-NC-SA-4.0"

# BirdNET-Go upstream defaults (ENTRYPOINT /usr/bin/birdnet-go, CMD realtime,
# volumes /config + /data, port 8080) are inherited unchanged.
