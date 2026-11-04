# 2ip Probe

![2ip Probe](assets/2ip-probe-github-640x320.png)

2ip Probe is a service that runs on your server. It lets visitors measure their
internet connection speed to your server and provides ping and traceroute
measurements that help 2ip improve and validate its IP geolocation database.

## Download

Download a build for your operating system and CPU architecture from
[GitHub Releases](https://github.com/twoip/probe/releases). Each release lists
the builds available for that version.

## Install and register

1. Sign in to [2ip.io](https://2ip.io/login/) and open [My probes](https://2ip.io/probes/).
2. Follow the installation instructions for your operating system. Your account
   ID is included in the personalized commands. Keep it private.
3. Allow inbound TCP traffic on port **8002**, or on the port you configured,
   in your server and hosting provider firewalls. The probe also needs outbound
   HTTPS access to `2ip.io` for registration and certificates.
4. Start the service and refresh **My probes**. Once registration succeeds, your
   probe will appear in the list.

## Permissions

The probe uses raw ICMP sockets for ping and traceroute. On Linux with systemd,
it can run as an unprivileged user with `AmbientCapabilities=CAP_NET_RAW`.
Follow the instructions in **My probes** for the appropriate service
configuration.

## Why host a probe?

Your probe adds another location for internet speed tests. You can add a link
to your project that appears on the [speed test map](https://2ip.io/speed/) and
in the [probe rankings](https://2ip.io/speed-platform-top/). Probes that run
continuously for more than one month also qualify for free 2ip Premium.

## Report a problem

Open an [issue](https://github.com/twoip/probe/issues) and include the probe
version, your operating system and CPU architecture, and any relevant log
messages. Remove your account ID and API keys before posting.

