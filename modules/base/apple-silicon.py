from pyinfra.operations import brew, files, server

server.shell(
    name="Installing Homebrew",
    commands=[
        '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
    ],
)

brew.packages(
    name="Install GnuPG tools",
    packages=["gnupg", "hopenpgp-tools"],
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

brew.packages(
    name="Install SmartCard tools",
    packages=["yubikey-personalization"],
)

brew.packages(
    name="Install ZSH",
    packages=["zsh"],
)

brew.packages(
    name="Install shell prompt",
    packages=["starship"],
)
