from pyinfra.operations import pacman

pacman.packages(
    name="Install essential packages",
    _sudo=True,
    packages=[
        "openssh",
        "rsync",
        "curl",
        "wget",
        "tree",
        "htop",
        "zip",
        "unzip",
        "man-db",
        "man-pages",
        "moreutils",
        "xdg-user-dirs",
    ],
)

# aur.packages(name="Install restore tool", packages=["timeshift"])

# aur.packages(name="Install kernel manager", packages=["kmon"])

pacman.packages(name="Install tracer", _sudo=True, packages=["strace"])

pacman.packages(name="Install mounting helper", _sudo=True, packages=["udisks2"])
