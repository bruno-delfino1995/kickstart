from pyinfra.operations import pacman, systemd

pacman.packages(
    name="Install avahi",
    _sudo=True,
    packages=["avahi", "nss-mdns"],
)

systemd.service(
    name="Enable avahi",
    _sudo=True,
    service="avahi-daemon",
    enabled=True,
    running=True,
)

pacman.packages(
    name="Install printing daemon",
    _sudo=True,
    packages=["cups"],
)

systemd.service(
    name="Enable printing socket",
    _sudo=True,
    service="cups.socket",
    enabled=True,
    running=True,
)
