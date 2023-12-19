from sys import argv
from importlib import import_module


def load_passwd(name='passwd', *modules):
    for module in modules:
        try:
            m = import_module(module)
            return getattr(m, name)
        except (AttributeError, ModuleNotFoundError):
            pass
    raise ImportError(f"Cannot load function '{name}' from any of the following modules: {modules}")


passwd = load_passwd("passwd", "notebook.auth", "jupyter_server.auth")

DEFAULT_PATH = "/run/secrets/jupyter_password"

clear_password = open(argv[1] if len(argv) > 1 else DEFAULT_PATH, "r").read().strip()

print(passwd(clear_password))
