#!/bin/bash
# Edited version from: /usr/local/bin/start-notebook.sh
set -e

# The Jupyter command to launch
# JupyterLab by default
DOCKER_STACKS_JUPYTER_CMD="${DOCKER_STACKS_JUPYTER_CMD:=lab}"

if [[ -n "${JUPYTERHUB_API_TOKEN}" ]]; then
    echo "WARNING: using start-singleuser.sh instead of start-notebook.sh to start a server associated with JupyterHub."
    exec /usr/local/bin/start-singleuser.sh "$@"
fi

wrapper=""
if [[ "${RESTARTABLE}" == "yes" ]]; then
    wrapper="run-one-constantly"
fi

/usr/bin/apt-get update
/usr/bin/apt-get install -y openssh-server
service ssh start

python /install-stuff.py

PWD_HASH="$(python /gen-pwd.py)"

# shellcheck disable=SC1091,SC2086
exec /usr/local/bin/start.sh ${wrapper} jupyter ${DOCKER_STACKS_JUPYTER_CMD} --NotebookApp.password=$PWD_HASH ${NOTEBOOK_ARGS} "$@"
