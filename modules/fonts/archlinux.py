from pyinfra.operations import pacman

pacman.packages(
    name="Install official fonts",
    _sudo=True,
    packages=[
        "ttf-dejavu",
        "ttf-fira-mono",
        "noto-fonts",
        "noto-fonts-emoji",
        "noto-fonts-extra",
        "adobe-source-code-pro-fonts",
        "otf-font-awesome",
    ],
)

# aur.packages(
#     name="Install community fonts",
#     packages=["lexend-fonts-git", "ttf-juliamono", "ttf-line-awesome"],
# )

pacman.packages(
    name="Install editor",
    _sudo=True,
    packages=["fontforge"],
)

pacman.packages(
    name="Install conversion tool",
    _sudo=True,
    packages=["woff2"],
)
