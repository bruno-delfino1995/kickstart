from pyinfra import host
from pyinfra.operations import brew, files, server

brew.packages(
    name="Install GnuPG tools",
    packages=["gnupg"],
)

brew.packages(
    name="Install SmartCard tools",
    packages=["yubikey-personalization"],
)

brew.packages(
    name="Install pinentry",
    packages=["pinentry-mac"],
)

server.shell(
    name="Import public key",
    commands=[f"gpg --recv-keys '{host.data.get('user').get('gpg')}'"],
)
