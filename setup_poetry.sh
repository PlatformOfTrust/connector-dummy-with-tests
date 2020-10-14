#!/usr/bin/env sh
set -exuo pipefail

# NOTICE!
#
# THIS FILE IS USED DURING THE BUILD OF DOCKER IMAGES, NOT DURING RUNTIME.
#
# DO NOT ADD ANYTHING THAT IS ENVIRONMENT SPECIFIC OR DEPENDS ON RUNTIME CONFIG
# IN THIS FILE.

# Install poetry the correct way
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py -o /tmp/get-poetry.py
python /tmp/get-poetry.py --version "${POETRY_VERSION}"
chmod +x "${POETRY_HOME}/bin/poetry"

python -m pip install --upgrade pip
poetry config virtualenvs.in-project false
poetry config virtualenvs.path "${WORKON_HOME}"
poetry run pip install uwsgi==2.0.17.1
poetry install
