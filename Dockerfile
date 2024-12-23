# Use a specific version of Alpine for reproducibility
FROM alpine:3.12

# Install necessary packages and clean up to reduce image size
RUN echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk add --no-cache wireguard-tools dante-server openresolv ip6tables && \
    rm -rf /var/cache/apk/*

# Copy the entrypoint script and set executable permissions
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Copy the SOCKS5 configuration file into the container
COPY sockd.conf /etc/sockd.conf

# Set the container's entrypoint to execute the script
ENTRYPOINT ["/entrypoint.sh"]

# Health check to ensure the container is running properly
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
    CMD pgrep -f wireguard || exit 1