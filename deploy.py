from pyinfra import host, local
import os.path

for module in host.data.get("modules"):
    dir = f"./modules/{module}"
    if not os.path.isdir(dir):
        raise Exception(f"Invalid module: {module}; there's no directory at '{dir}'")

    local.include("./roles/install.py", data={"module": module})
    local.include("./roles/config.py", data={"module": module})
