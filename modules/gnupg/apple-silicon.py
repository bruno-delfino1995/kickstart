from pyinfra.operations import brew, files

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

files.link(
    name="Link pinentry",
    _sudo=True,
    path="/usr/local/bin/pinentry-proxy",
    target="/usr/local/bin/pinentry-mac",
)

server.shell(
    name="Import public key",
    commands=[f"gpg --recv-keys '{host.data.get('user').get('gpg')}'"],
)
