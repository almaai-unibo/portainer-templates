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

PWD_HASH="$(python /gen-pwd.py)"

jupyter ${DOCKER_STACKS_JUPYTER_CMD} --allow-root --NotebookApp.password=$PWD_HASH ${NOTEBOOK_ARGS} "$@"
