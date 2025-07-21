from pyinfra.operations import pacman

pacman.packages(
    name="Install git",
    _sudo=True,
    packages=["git"],
)
