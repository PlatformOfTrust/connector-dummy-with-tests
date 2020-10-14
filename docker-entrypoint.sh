#!/bin/sh
set -exuo pipefail

if [[ "${ENV}" == "development" ]]; then
  command="dev"
else
  command="uwsgi"
fi

set -- poetry run invoke "${command}"

exec "$@"
