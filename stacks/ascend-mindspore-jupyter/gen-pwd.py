from notebook.auth import passwd
from sys import argv

DEFAULT_PATH = "/run/secrets/jupyter_password"

clear_password = open(argv[1] if len(argv) > 1 else DEFAULT_PATH, "r").read().strip()

print(passwd(clear_password))
