import sys
import os
import pip


FURTHER_APT_PACKAGES_TO_INSTALL = os.getenv("FURTHER_APT_PACKAGES_TO_INSTALL", "").split()

FURTHER_PIP_PACKAGES_TO_INSTALL = os.getenv("FURTHER_PIP_PACKAGES_TO_INSTALL", "").split()


def install_pip(package):
    pip.main(["install", package])


def install_apt(package):
    os.system("/usr/bin/apt-get install -y " + package)


if FURTHER_APT_PACKAGES_TO_INSTALL:
    for package in FURTHER_APT_PACKAGES_TO_INSTALL:
        install_apt(package)
else:
    print("No further apt packages to install")

if FURTHER_PIP_PACKAGES_TO_INSTALL:
    for package in FURTHER_PIP_PACKAGES_TO_INSTALL:
        install_pip(package)
else:
    print("No further pip packages to install")
