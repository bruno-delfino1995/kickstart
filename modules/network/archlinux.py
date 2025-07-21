from pyinfra.operations import pacman, server, systemd

pacman.packages(
    name="Install NetworkManager",
    _sudo=True,
    packages=["networkmanager"],
)

pacman.packages(
    name="Install wireless daemon",
    _sudo=True,
    packages=["iwd"],
)

systemd.service(
    name="Enable NetworkManager",
    _sudo=True,
    service="NetworkManager",
    enabled=True,
    running=True,
)

pacman.packages(
    name="Install generic tools",
    _sudo=True,
    packages=["bind-tools", "ngrep", "ldns"],
)

systemd.service(
    name="Enable systemd-timesyncd",
    _sudo=True,
    service="systemd-timesyncd",
    enabled=True,
    running=True,
)

server.shell(
    name="Enable NTP",
    _sudo=True,
    commands=["timedatectl set-ntp true"],
)

pacman.packages(
    name="Install OpenVPN",
    _sudo=True,
    packages=["openvpn"],
)

pacman.packages(
    name="Install NetworkManager VPN Helper",
    _sudo=True,
    packages=["networkmanager-openvpn"],
)
