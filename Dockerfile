# Use a minimal base image for reduced size and security
FROM alpine:latest

# Temporarily enable the Alpine edge/testing repository for specific packages
RUN echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && apk add --no-cache wireguard-tools dante-server openresolv ip6tables \
    && sed -i '/edge\/testing/d' /etc/apk/repositories

# Copy the entrypoint script into the container
COPY entrypoint.sh /entrypoint.sh

# Copy the SOCKS5 configuration file into the container
COPY sockd.conf /etc/sockd.conf

# Ensure the entrypoint script has executable permissions
RUN chmod +x /entrypoint.sh

# Set the container's entrypoint to execute the script
ENTRYPOINT ["/entrypoint.sh"]