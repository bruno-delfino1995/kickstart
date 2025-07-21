from pyinfra import host
from pyinfra.operations import pacman, server, systemd

pacman.packages(
    name="Install GNUPG",
    _sudo=True,
    packages=["gnupg"],
)

pacman.packages(
    name="Install SmartCard tools",
    _sudo=True,
    packages=["opensc", "ccid"],
)

systemd.service(
    name="Enable SmartCard service",
    _sudo=True,
    service="pcscd.service",
    enabled=True,
    running=True,
)

# aur.packages(name="Install pinentry", packages=["pinentry-rofi"])

server.shell(
    name="Import public key",
    commands=[f"gpg --recv-keys '{host.data.get('user').get('gpg')}'"],
)
