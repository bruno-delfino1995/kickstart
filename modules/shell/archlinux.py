from pyinfra.operations import pacman

pacman.packages(
    name="Install ZSH",
    _sudo=True,
    packages=["zsh"],
)

pacman.packages(
    name="Install ZSH plugin manager",
    _sudo=True,
    packages=["sheldon"],
)

pacman.packages(
    name="Install shell prompt",
    _sudo=True,
    packages=["starship"],
)

pacman.packages(
    name="Install file helpers",
    _sudo=True,
    packages=["fd", "fzf", "ripgrep", "tree", "ranger"],
)

pacman.packages(
    name="Install terminal multiplexer",
    _sudo=True,
    packages=["tmux"],
)

# aur.packages(name="Install multiplexer configurator", packages=["tmuxinator"])

pacman.packages(
    name="Install env vars autoloader",
    _sudo=True,
    packages=["direnv"],
)

pacman.packages(
    name="Install smarter cd",
    _sudo=True,
    packages=["zoxide"],
)

pacman.packages(
    name="Install usage helper",
    _sudo=True,
    packages=["man-db", "man-pages", "tldr"],
)

pacman.packages(
    name="Install compression tools",
    _sudo=True,
    packages=["zip", "unzip"]
)

pacman.packages(
    name="Install network clients",
    _sudo=True,
    packages=["curl", "wget"]
)

pacman.packages(
    name="Install common utilities",
    _sudo=True,
    packages=["moreutils"]
)
