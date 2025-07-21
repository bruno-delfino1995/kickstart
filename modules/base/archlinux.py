from pyinfra.operations import files, pacman, systemd

# aur.packages(name="Install AUR helper", packages=["paru"], use="makepkg")

pacman.packages(
    name="Install GnuPG tools",
    _sudo=True,
    packages=["gnupg", "hopenpgp-tools"],
)

# aur.packages(name="Install pinentry", packages=["pinentry-rofi"])

files.link(
    name="Link pinentry",
    _sudo=True,
    path="/usr/local/bin/pinentry-proxy",
    target="/usr/bin/pinentry-rofi",
)

pacman.packages(
    name="Install SmartCard tools",
    _sudo=True,
    packages=["pcsclite", "opensc", "ccid", "yubikey-personalization"],
)

systemd.service(
    name="Enable SmartCard service",
    _sudo=True,
    service="pcscd",
    enabled=True,
    running=True,
)

pacman.packages(
    name="Install ZSH",
    _sudo=True,
    packages=["zsh"],
)

pacman.packages(
    name="Install shell prompt",
    _sudo=True,
    packages=["starship"],
)
