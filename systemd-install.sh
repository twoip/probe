#!/bin/sh
set -eu

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 ACCOUNT_ID RELEASE_ARCHIVE_URL" >&2
    exit 2
fi

case "$1" in
    ''|*[!A-Za-z0-9_-]*)
        echo "Invalid account ID" >&2
        exit 2
        ;;
esac

if [ "$(uname -s)" != Linux ] || [ "$(id -u)" != 0 ] || ! command -v systemctl >/dev/null; then
    echo "Run this installer as root on Linux with systemd" >&2
    exit 1
fi

work_dir=$(mktemp -d)
trap 'rm -rf "$work_dir"' EXIT
trap 'exit 1' HUP INT TERM

curl --fail --silent --show-error --location --output "$work_dir/probe.tar.gz" -- "$2"
tar -xzf "$work_dir/probe.tar.gz" -C "$work_dir" 2ip-probe

cat > "$work_dir/2ip-probe.service" <<EOF_UNIT
[Unit]
Description=2ip Probe
After=network.target

[Service]
User=nobody
AmbientCapabilities=CAP_NET_RAW
ExecStart=/usr/local/bin/2ip-probe --id=$1
Restart=always
RestartSec=5
LimitNOFILE=8192

[Install]
WantedBy=multi-user.target
EOF_UNIT

install -d -m 0755 /usr/local/bin
install -m 0755 "$work_dir/2ip-probe" /usr/local/bin/2ip-probe
install -m 0600 "$work_dir/2ip-probe.service" /etc/systemd/system/2ip-probe.service
systemctl daemon-reload
systemctl enable 2ip-probe.service
systemctl restart 2ip-probe.service
systemctl is-active 2ip-probe.service
