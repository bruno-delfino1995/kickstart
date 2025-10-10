import os
from datetime import datetime

from pyinfra.operations import pacman, server, systemd

pacman.update(name="Update database", _sudo=True)

pacman.packages(
    name="Install mirrors updater",
    _sudo=True,
    packages=["reflector"],
)


def should_refresh_mirrorlist():
    try:
        with open("/etc/pacman.d/mirrorlist", "r") as f:
            contents = f.read()
        stats = os.stat("/etc/pacman.d/mirrorlist")
        mtime = stats.st_mtime
        now = datetime.now().timestamp()
        return "Reflector" not in contents or (now - mtime) > (7 * 60 * 60 * 24)
    except FileNotFoundError:
        return True


if should_refresh_mirrorlist():
    server.shell(
        name="Refresh mirrorlist",
        _sudo=True,
        commands=[
            "reflector --protocol https --age 48 --latest 100 --fastest 50 --save /etc/pacman.d/mirrorlist"
        ],
    )

systemd.service(
    name="Enable mirrorlist auto-update",
    _sudo=True,
    service="reflector.timer",
    enabled=True,
    running=True,
)

# aur.packages(name="Install AUR helper", packages=["paru"], use="makepkg")
