from pyinfra.operations import files

files.link(
    name="Link pinentry",
    _sudo=True,
    path="/usr/local/bin/pinentry-proxy",
    target="/usr/local/bin/pinentry-mac",
)

