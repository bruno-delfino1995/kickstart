from pyinfra import host
from pyinfra.api import operation
from pyinfra.facts.server import Home
from pyinfra.operations import files
from pathlib import Path
import os

module = host.data.get("module")
kind = host.data.get("kind")

cwd = os.getcwd()
dir = f"{cwd}/modules/{module}"


@operation()
def directories(source, target):
    yield from files.directory._inner(
        path=target,
        present=True,
    )

    for path in Path(source).rglob("*"):
        if path.is_dir():
            relative_to_source = str(path.relative_to(Path(source)))
            in_target = Path(target) / relative_to_source

            yield from files.directory._inner(
                path=str(in_target),
                present=True,
            )


@operation()
def links(source, target):
    yield from directories._inner(source, target)

    for path in Path(source).rglob("*"):
        if path.is_file():
            relative_to_source = str(path.relative_to(Path(source)))
            in_target = Path(target) / relative_to_source

            yield from files.link._inner(
                path=str(in_target),
                target=str(path),
                present=True,
                symbolic=True,
                force=True,
                force_backup=False,
            )


@operation()
def copies(source, target):
    yield from directories._inner(source, target)

    for path in Path(source).rglob("*"):
        if path.is_file():
            relative_to_source = str(path.relative_to(Path(source)))
            in_target = Path(target) / relative_to_source

            yield from files.put._inner(dest=str(in_target), src=str(path), mode=True)


def try_links(name, source, target, sudo=False):
    path = Path(source)
    if path.is_dir():
        links(name=name, source=source, target=target, _sudo=sudo)


def try_copies(name, source, target, sudo=False):
    path = Path(source)
    if path.is_dir():
        links(name=name, source=source, target=target, _sudo=sudo)


user_dir = host.get_fact(Home)
try_links("Link common user files", f"{dir}/common/user", user_dir)
try_links(f"Link {kind} user files", f"{dir}/{kind}/user", user_dir)

system_dir = "/"
try_copies("Place common system files", f"{dir}/common/system", system_dir, sudo=True)
try_copies(f"Place {kind} system files", f"{dir}/{kind}/system", system_dir, sudo=True)
