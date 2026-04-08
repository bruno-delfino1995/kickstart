from pyinfra.operations import brew, files, server

brew.packages(
    name="Install keyboard customizer",
    packages=["karabiner-elements"],
)

brew.packages(
    name="Install key screencasting",
    packages=["keycastr"]
)

brew.packages(
    name="Install mouse customizations",
    packages=[
        "sensiblesidebuttons",
        "unnaturalscrollwheels"
    ]
)
