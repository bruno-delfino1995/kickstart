from pyinfra import host
from pyinfra.operations import files, pacman, server, systemd

pacman.packages(
    name="Install GnuPG tools",
    _sudo=True,
    packages=["gnupg"],
)

pacman.packages(
    name="Install SmartCard tools",
    _sudo=True,
    packages=["pcsclite", "ccid", "yubikey-personalization"],
)

systemd.service(
    name="Enable SmartCard service",
    _sudo=True,
    service="pcscd.service",
    enabled=True,
    running=True,
)

# aur.packages(name="Install pinentry", packages=["pinentry-rofi"])

files.link(
    name="Link pinentry",
    _sudo=True,
    path="/usr/local/bin/pinentry-proxy",
    target="/usr/bin/pinentry-rofi",
)

server.shell(
    name="Import public key",
    commands=[f"gpg --recv-keys '{host.data.get('user').get('gpg')}'"],
)
