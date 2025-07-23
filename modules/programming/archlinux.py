from pyinfra import host
from pyinfra.facts.server import User
from pyinfra.operations import pacman, server, systemd

pacman.packages(
    name="Install Docker",
    _sudo=True,
    packages=["docker", "docker-compose"],
)

systemd.service(
    name="Enable Docker",
    _sudo=True,
    service="docker",
    enabled=True,
    running=True,
)

user = host.get_fact(User)

server.user(
    name="Add user to docker group",
    _sudo=True,
    user=user,
    groups=["docker"],
    append=True,
)

# aur.packages(name="Install GCP CLI", packages=["google-cloud-sdk"])

# aur.packages(name="Install Postman", packages=["postman-bin"])
