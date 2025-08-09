import importlib
from typing import Dict, Any


def get_data(host: str) -> Dict[str, Any]:
    """
    Looks up a host data module and return its variables as a dictionary.
    Returns an empty dictionary if the module doesn't exist or can't be loaded.

    Args:
        module_name (str): Name of the host (like 'local', 'server')

    Returns:
        Dict[str, Any]: Dictionary containing all variables from the module,
                       or empty dictionary if loading fails
    """
    try:
        module_name = f"host_data.{host}"
        module = importlib.import_module(module_name)

        return {k: v for k, v in module.__dict__.items() if not k.startswith("__")}

    except ModuleNotFoundError as _:
        return {}


hosts = [("@local", get_data("local"))]
