from pyinfra.operations import pacman

pacman.packages(
    name="Install essential packages",
    _sudo=True,
    packages=[
        "openssh",
    ],
)
