from pyinfra.operations import pacman

pacman.packages(
    name="Install sync tool",
    _sudo=True,
    packages=["rsync"],
)

# aur.packages(name="Install restore tool", packages=["timeshift"])
