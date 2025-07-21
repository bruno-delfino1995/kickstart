from pyinfra import host, local
import os.path


kind = host.data.get("kind")

for module in host.data.get("modules"):
    file = f"./modules/{module}/{kind}.py"

    if os.path.isfile(file):
        local.include(file)
