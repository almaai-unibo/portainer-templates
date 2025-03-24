#!/bin/bash
# Edited version from: /usr/local/bin/start-notebook.sh
set -e

# trim variable FURTHER_APT_PACKAGES_TO_INSTALL
FURTHER_APT_PACKAGES_TO_INSTALL=$(echo "${FURTHER_APT_PACKAGES_TO_INSTALL}" | awk '{$1=$1; print}')
if [[ -n "${FURTHER_APT_PACKAGES_TO_INSTALL}" ]]; then
    /usr/bin/apt-get update
    echo "/usr/bin/apt-get install -y ${FURTHER_APT_PACKAGES_TO_INSTALL}"
    /usr/bin/apt-get install -y ${FURTHER_APT_PACKAGES_TO_INSTALL}
fi

# trim variable FURTHER_PIP_PACKAGES_TO_INSTALL
FURTHER_PIP_PACKAGES_TO_INSTALL=$(echo "${FURTHER_PIP_PACKAGES_TO_INSTALL}" | awk '{$1=$1; print}')
if [[ -n "${FURTHER_PIP_PACKAGES_TO_INSTALL}" ]]; then
    echo "/opt/conda/bin/pip install ${FURTHER_PIP_PACKAGES_TO_INSTALL}"
    /opt/conda/bin/pip install ${FURTHER_PIP_PACKAGES_TO_INSTALL}
fi

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

PWD_HASH="$(python /gen-pwd.py)"

# shellcheck disable=SC1091,SC2086
exec /usr/local/bin/start.sh ${wrapper} jupyter ${DOCKER_STACKS_JUPYTER_CMD} --NotebookApp.password=$PWD_HASH ${NOTEBOOK_ARGS} "$@"
