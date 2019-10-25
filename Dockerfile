FROM alpine
WORKDIR /app
ENV packages python3 ca-certificates git
RUN apk add --no-cache $packages \
    || (apt update && apt install -y $packages) \
    || yum install -y $packages
COPY backup-manifest /app
ENTRYPOINT ["python3","/app/backup-manifest"]