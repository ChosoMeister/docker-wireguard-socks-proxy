#!/bin/sh

set -e  # Exit on error

# Dynamically detect the WireGuard interface name
ifname=$(basename $(ls -1 /etc/wireguard/*.conf | head -1) .conf)

# Bring up the WireGuard interface with the configuration file
wg-quick up /etc/wireguard/$ifname.conf

# Ensure ip6tables is properly set up for IPv6 traffic
ip6tables -P FORWARD ACCEPT
ip6tables -A FORWARD -i $ifname -j ACCEPT
ip6tables -A FORWARD -o $ifname -j ACCEPT

# Replace placeholder in SOCKS5 config with the actual WireGuard interface
sed -i'' -e "s/__replace_me_ifname__/$ifname/" /etc/sockd.conf

# Start the Dante SOCKS5 proxy server
/usr/sbin/sockd -f /etc/sockd.conf
