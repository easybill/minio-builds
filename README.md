# MinIO Automated Builds

This repository provides automated builds of [MinIO](https://github.com/minio/minio) for Linux platforms (amd64 and arm64).

## About

MinIO switched to a source-only distribution model. This repository automatically:
- Monitors the official MinIO releases
- Builds binaries for Linux (amd64 and arm64)
- Publishes them as GitHub releases

Latest Release: RELEASE.2025-10-15T17-29-55Z

Last Updated: 2025-10-22

## Download

Download the latest binaries from the [Releases](https://github.com/easybill/minio/releases) page.

### Available Binaries

- **minio-linux-amd64**: Linux x86_64 (Intel/AMD 64-bit)
- **minio-linux-arm64**: Linux ARM64 (aarch64)

## Build Information

All binaries are built from the official MinIO source code using:
```bash
env GOOS=linux GOARCH=[amd64|arm64] CGO_ENABLED=0 go build
```

## License

MinIO is licensed under the GNU AGPLv3. See the [official MinIO repository](https://github.com/minio/minio) for details.

The source code used to build the executables is always attached to the binary release on GitHub.

## Upstream

Official MinIO Repository: https://github.com/minio/minio

## Disclaimer

This is an unofficial build repository maintained by easybill. For official support, please refer to the upstream MinIO project.
