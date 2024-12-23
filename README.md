To improve the documentation for your `docker-wireguard-socks-proxy` project, we can enhance the README file by adding more detailed sections and explanations. Here's an improved version of your README file:

---

# docker-wireguard-socks-proxy

Expose WireGuard as a SOCKS5 proxy in a Docker container.

## Table of Contents

- [Usage](#usage)
- [Configuration](#configuration)
- [Example Scenarios](#example-scenarios)
- [HTTP Proxy](#http-proxy)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

## Usage

You can use `docker run` directly if you want to customize things such as port mapping:

```bash
docker run -it --rm --cap-add=NET_ADMIN \
    --name wireguard-socks-proxy \
    --volume /directory/containing/your/wireguard/conf/file/:/etc/wireguard/:ro \
    -p 1080:1080 \
    ghcr.io/chosomeister/docker-wireguard-socks-proxy:latest
```

Then connect to the SOCKS proxy through `127.0.0.1:1080` (or `local.docker:1080` for Mac / docker-machine / etc.). For example:

```bash
curl --proxy socks5h://127.0.0.1:1080 ipinfo.io
```

## Configuration

### WireGuard Configuration

Ensure your WireGuard configuration file is correctly set up and placed in the specified directory. The container will read this configuration to establish the VPN connection.

### Environment Variables

You can customize the container behavior using environment variables:

- `WG_CONFIG`: Path to the WireGuard configuration file inside the container.
- `PROXY_PORT`: Port on which the SOCKS5 proxy will listen (default: 1080).

Example:

```bash
docker run -it --rm --cap-add=NET_ADMIN \
    --name wireguard-socks-proxy \
    --volume /directory/containing/your/wireguard/conf/file/:/etc/wireguard/:ro \
    -e WG_CONFIG=/etc/wireguard/wg0.conf \
    -e PROXY_PORT=1080 \
    -p 1080:1080 \
    ghcr.io/chosomeister/docker-wireguard-socks-proxy:latest
```

## Example Scenarios

### Using SOCKS5 Proxy with a Web Browser

Configure your web browser to use the SOCKS5 proxy at `127.0.0.1:1080` to route all traffic through the WireGuard VPN.

### Converting SOCKS5 to HTTP Proxy

You can easily convert this to an HTTP proxy using [http-proxy-to-socks](https://github.com/oyyd/http-proxy-to-socks):

```bash
hpts -s 127.0.0.1:1080 -p 8080
```

## HTTP Proxy

You can convert the SOCKS5 proxy to an HTTP proxy using [http-proxy-to-socks](https://github.com/oyyd/http-proxy-to-socks), e.g.

```bash
hpts -s 127.0.0.1:1080 -p 8080
```

## Troubleshooting

### I get "Permission Denied"

This can happen if your WireGuard configuration file includes an IPv6 address but your host interface does not work with it. Try removing the IPv6 address in `Address` from your configuration file.

### Common Issues

- Ensure that Docker has the necessary permissions and capabilities (`--cap-add=NET_ADMIN`).
- Verify that the WireGuard configuration file is correctly formatted and accessible by the container.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any improvements or bug fixes.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

This improved README provides a more comprehensive guide, covering usage, configuration, example scenarios, troubleshooting, and contribution guidelines. Feel free to customize further based on specific needs or additional features of your project.
