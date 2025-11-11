# Based on the Dockerfile from MinIO official repository: https://github.com/minio/minio/blob/58659f26f45f2c189f5fd1c7267da60c10024daa/Dockerfile.release
FROM curlimages/curl:latest AS build
ARG TARGETARCH

USER root

WORKDIR /build
RUN apk add -U --no-cache ca-certificates
RUN curl -s -q https://dl.min.io/client/mc/release/linux-${TARGETARCH}/mc -o mc && chmod +x mc

COPY minio-linux-${TARGETARCH} minio
RUN chmod +x minio

FROM registry.access.redhat.com/ubi10-micro:latest
ARG RELEASE

LABEL name="MinIO" \
      vendor="easybill" \
      maintainer="easybill" \
      version="${RELEASE}" \
      release="${RELEASE}" \
      summary="MinIO is a High Performance Object Storage, API compatible with Amazon S3 cloud storage service." \
      description="MinIO object storage is fundamentally different. Designed for performance and the S3 API, it is 100% open-source. MinIO is ideal for large, private cloud environments with stringent security requirements and delivers mission-critical availability across a diverse range of workloads."

ENV MINIO_ACCESS_KEY_FILE=access_key \
    MINIO_SECRET_KEY_FILE=secret_key \
    MINIO_ROOT_USER_FILE=access_key \
    MINIO_ROOT_PASSWORD_FILE=secret_key \
    MINIO_KMS_SECRET_KEY_FILE=kms_master_key \
    MINIO_CONFIG_ENV_FILE=config.env \
    MC_CONFIG_DIR=/tmp/.mc

RUN chmod -R 777 /usr/bin

COPY --from=build /build/mc /usr/bin/
COPY --from=build /build/minio /usr/bin/
COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

COPY minio-source/CREDITS /licenses/CREDITS
COPY minio-source/LICENSE /licenses/LICENSE
COPY minio-source/dockerscripts/docker-entrypoint.sh /usr/bin/docker-entrypoint.sh

EXPOSE 9000
VOLUME ["/data"]

ENTRYPOINT ["/usr/bin/docker-entrypoint.sh"]
CMD ["minio"]