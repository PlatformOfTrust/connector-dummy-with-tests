#!/usr/bin/env sh
set -exuo pipefail

# NOTICE!
#
# THIS FILE IS USED DURING THE BUILD OF DOCKER IMAGES, NOT DURING RUNTIME.
#
# DO NOT ADD ANYTHING THAT IS ENVIRONMENT SPECIFIC OR DEPENDS ON RUNTIME CONFIG
# IN THIS FILE.

COMMON_LIB_PATH="../../lib"
mv "./lib" "${COMMON_LIB_PATH}"

if [[ ! -d "${WORKON_HOME}" ]]; then
  mkdir "${WORKON_HOME}"
fi

rm -rf "${WORKON_HOME:?}"/*

./setup_poetry.sh
