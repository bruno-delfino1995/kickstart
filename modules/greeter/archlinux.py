from pyinfra.operations import systemd

# aur.packages(name="Install greeter", packages=["greetd"])

# aur.packages(name="Install greeter theme", packages=["greetd-tuigreet"])

systemd.service(
    name="Enable greeter",
    _sudo=True,
    service="greetd",
    enabled=True,
)
