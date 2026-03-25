#!/usr/bin/env bash

set -xeu -o pipefail

# Define mitogen version
MITOGEN_VERSION='0.3.37'
# Define mitogen installation path
MITOGEN_PATH="$HOME/python_envs/ansible/lib/python3.12/site-packages/"

rm -rf "${MITOGEN_PATH}/mitogen" || true
wget https://github.com/mitogen-hq/mitogen/releases/download/v${MITOGEN_VERSION}/mitogen-${MITOGEN_VERSION}.tar.gz -O /tmp/mitogen.tar.gz
tar -xvf /tmp/mitogen.tar.gz --strip-components=1 -C "$MITOGEN_PATH" mitogen-${MITOGEN_VERSION}/ansible_mitogen mitogen-${MITOGEN_VERSION}/mitogen
