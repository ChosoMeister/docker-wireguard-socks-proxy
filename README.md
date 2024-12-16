# docker-wireguard-socks-proxy

Expose WireGuard as a SOCKS5 proxy in a Docker container.

## Usage

you can use `docker run` directly if you want to customize things such as port mapping:

```bash
docker run -it --rm --cap-add=NET_ADMIN \
    --name wireguard-socks-proxy \
    --volume /directory/containing/your/wireguard/conf/file/:/etc/wireguard/:ro \
    -p 1080:1080 \
    ghcr.io/chosomeister/docker-wireguard-socks-proxy:latest
```

Then connect to SOCKS proxy through through `127.0.0.1:1080` (or `local.docker:1080` for Mac / docker-machine / etc.). For example:

```bash
curl --proxy socks5h://127.0.0.1:1080 ipinfo.io
```

## HTTP Proxy

You can easily convert this to an HTTP proxy using [http-proxy-to-socks](https://github.com/oyyd/http-proxy-to-socks), e.g.

```bash
hpts -s 127.0.0.1:1080 -p 8080
```

## Troubleshooting

### I get "Permission Denied"

This can happen if your WireGuard configuration file includes an IPv6 address but your host interface does not work with it. Try removing the IPv6 address in `Address` from your configuration file.
