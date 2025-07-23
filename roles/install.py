from pyinfra import host, local
import os.path

module = host.data.get("module")
kind = host.data.get("kind")

cwd = os.getcwd()
modules = f"{cwd}/modules"


def include_task(name):
    task = f"{modules}/{module}/{name}.py"
    if os.path.isfile(task):
        local.include(task)


include_task("common")
include_task(kind)
