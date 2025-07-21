from pyinfra.operations import pacman

pacman.packages(
    name="Install terminal editor",
    _sudo=True,
    packages=["neovim"],
)
