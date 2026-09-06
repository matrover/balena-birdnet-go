# BirdNET-Go for balenaOS

[![Deploy with balena](https://www.balena.io/deploy.svg)](https://dashboard.balena-cloud.com/deploy?repoUrl=https://github.com/matrover/balena-birdnet-go)

![BirdNET-Go logo](logo.webp)

Realtime bird sound recognition on a Raspberry Pi running [balenaOS](https://balena.io), built on [BirdNET-Go](https://github.com/tphakala/birdnet-go).

- **Bird recognition**: 6,500+ bird species with the embedded BirdNET model; optional Google Perch v2, BattyBirdNET, and Geomodel models installable from the app.
- **Home Assistant integration**: built-in MQTT publishing with Home Assistant auto-discovery — detections show up as entities automatically.
- **Audio inputs**: USB sound card or RTSP streams (e.g. an ESP32 or IP microphone).
- **Web dashboard**: live spectrograms, detection heatmaps, and a fully local web UI on port 8080.

## Deployment

### One-click deploy

Click the *Deploy with balena* button above. This creates a fleet in your balenaCloud account, then add a device (Raspberry Pi 3/4/5 or Zero 2 W) and flash the downloaded OS image to an SD card.

### Manual deploy

```bash
balena login
git clone https://github.com/matrover/balena-birdnet-go
cd balena-birdnet-go
balena push <your-fleet-name>
```

## Setup after boot

1. Open the device's web dashboard (port **8080**; use the balena public device URL if the Pi is remote) and complete the onboarding wizard.
2. Add an audio source: a USB sound card (mapped into the container as `/dev/snd`; balenaOS exposes it automatically when a USB audio device is plugged in) or an RTSP stream URL.
3. In *Settings → Integrations → MQTT*, point BirdNET-Go at your MQTT broker (e.g. the Mosquitto add-on in Home Assistant). Home Assistant discovers the bird detection entities automatically.

## Why BirdNET-Go instead of BirdNET-Pi?

The original BirdNET-Pi has no official Docker support and is deprecated (maintenance moved to the Nachtzuster host-installation fork). [BirdNET-Go](https://github.com/tphakala/birdnet-go) is its actively maintained successor: it ships official multi-arch Docker images (amd64 + arm64), runs natively in containers, and has first-class MQTT + Home Assistant auto-discovery. A pre-existing balena image for either project did not exist, so this repo wraps BirdNET-Go's official image for balenaOS.

## Configuration

Settings are managed from the BirdNET-Go web UI and persist in the `birdnet-config` and `birdnet-data` volumes. Useful environment variables (edit `docker-compose.yml`):

| Variable | Default | Description |
|---|---|---|
| `TZ` | `Europe/Amsterdam` | Timezone |
| `BIRDNET_UID` / `BIRDNET_GID` | `1000` | File ownership for the volumes |

## Architecture of this repo

The stack builds locally on the device via the included `Dockerfile`, which is a thin wrapper around the official [`ghcr.io/tphakala/birdnet-go`](https://ghcr.io/tphakala/birdnet-go) multi-arch image, pinned by **digest** to a verified snapshot of upstream `latest` (digest `sha256:233b94f1...589143d6`, multi-arch amd64+arm64; `BIRDNET_GO_VERSION` build arg / compose build arg). A digest pin is immutable, so balena builds are reproducible even when upstream republishes tags. This keeps the build self-contained for balena's `docker build` while inheriting upstream's tested runtime (BirdNET model, MQTT, web UI, ALSA/sox tooling). To pin a different release, change `BIRDNET_GO_VERSION` in both the `Dockerfile` and `docker-compose.yml`. The service runs privileged with `/dev/snd` mapped so a USB sound card is directly usable.

## Credits

- [BirdNET-Go](https://github.com/tphakala/birdnet-go) by Tomi P. Hakala (CC BY-NC-SA 4.0 — non-commercial use)
- [BirdNET](https://birdnet.cornell.edu) by the K. Lisa Yang Center for Conservation Bioacoustics, Cornell Lab
