from pyinfra.operations import flatpak, pacman

pacman.packages(name="Install browser", _sudo=True, packages=["firefox"])

# aur.packages(name="Install password manager", packages=["enpass-bin"])

pacman.packages(name="Install terminal emulator", _sudo=True, packages=["wezterm"])

pacman.packages(name="Install flatpak", _sudo=True, packages=["flatpak"])

flatpak.packages(
    name="Install flatpak apps",
    packages=[
        "com.google.Chrome",
        "com.github.PintaProject.Pinta",
        "com.slack.Slack",
        "com.spotify.Client",
        "md.obsidian.Obsidian",
        "com.dropbox.Client",
        "re.sonny.Junction",
    ],
)

pacman.packages(
    name="Install file picker and plugins",
    _sudo=True,
    packages=[
        "thunar",
        "thunar-archive-plugin",
        "thunar-volman",
        "gvfs",
        "file-roller",
    ],
)
