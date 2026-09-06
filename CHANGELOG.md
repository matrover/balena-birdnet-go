# Changelog

All notable changes to this project will be documented in this file.

## [1.0.0] - 2026-09-06

### Added
- Initial balenaOS deployment of BirdNET-Go using the official multi-arch Docker image (`ghcr.io/tphakala/birdnet-go:latest`).
- `docker-compose.yml` with persistent config/data volumes and port 8080 for the web dashboard.
- `balena.yml` application metadata with deploy-with-balena support and post-provisioning instructions.
- README with deployment, setup, and Home Assistant MQTT integration instructions.
