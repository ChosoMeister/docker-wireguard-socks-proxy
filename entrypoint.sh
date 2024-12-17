#!/bin/sh

set -e

# Extract WireGuard interface name
ifname=$(basename $(ls -1 /etc/wireguard/*.conf | head -1) .conf)

# Bring up WireGuard interface
wg-quick up /etc/wireguard/$ifname.conf

# Flush existing IPv6 rules to avoid conflicts
ip6tables -F
ip6tables -P FORWARD ACCEPT
ip6tables -A FORWARD -i $ifname -j ACCEPT
ip6tables -A FORWARD -o $ifname -j ACCEPT

# Replace placeholder in SOCKS5 config
sed -i'' -e "s/__replace_me_ifname__/$ifname/" /etc/sockd.conf

# Start Dante SOCKS5 proxy
/usr/sbin/sockd -f /etc/sockd.conf
