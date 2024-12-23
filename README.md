# Docker WireGuard SOCKS5 Proxy

A Docker container that sets up a WireGuard interface and a SOCKS5 proxy using Dante.

## Project Overview

This project provides a Dockerized solution to set up a WireGuard VPN and a SOCKS5 proxy server. It uses Alpine Linux as the base image and installs WireGuard and Dante server to create a secure an...

## Prerequisites

- Docker installed on your machine.
- A valid WireGuard configuration file.

## Installation

1. **Clone the Repository**:

   ```bash
   git clone https://github.com/ChosoMeister/docker-wireguard-socks-proxy.git
   cd docker-wireguard-socks-proxy
   ```

2. **Build the Docker Image**:
   ```bash
   docker build -t wireguard-socks-proxy .
   ```

## Usage

1. **Prepare WireGuard Configuration**:

   - Place your WireGuard configuration file in the `config` directory and name it `wg0.conf`.

2. **Run the Docker Container**:

   ```bash
   docker run -d --name wireguard-socks-proxy --cap-add NET_ADMIN --device /dev/net/tun --volume $(pwd)/config:/etc/wireguard wireguard-socks-proxy
   ```

3. **Connect to the SOCKS5 Proxy**:
   - The SOCKS5 proxy will be available on the container's IP address at port 1080.

## Configuration

- **WireGuard Configuration**:

  - Place your WireGuard configuration file in the `config` directory and name it `wg0.conf`.
  - Ensure the configuration file is valid and contains the correct settings for your VPN.

- **SOCKS5 Configuration**:
  - The SOCKS5 proxy is configured using the `sockd.conf` file located in `/etc/sockd.conf` inside the container.
  - Modify this file to change proxy settings as needed.

## Contributing

We welcome contributions! Please follow these steps to contribute:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Make your changes and commit them (`git commit -m 'Add new feature'`).
4. Push to the branch (`git push origin feature-branch`).
5. Create a Pull Request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contact Information

For questions or support, please open an issue on GitHub or contact the maintainers at `your-email@example.com`.
