from pyinfra.operations import pacman

pacman.packages(
    name="Install terminal editor",
    _sudo=True,
    packages=["neovim"],
)

pacman.packages(
    name="Install visual editor"
    _sudo=True,
    packages=["emacs-wayland"]
)
