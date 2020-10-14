# python:3.6-alpine3.9 specific working version
FROM python@sha256:ad2b24eacc9865244d7b1ae198d507f4ce8f506484c35d27158e7f1dd6041a8b

ENV LC_ALL=C.UTF-8 \
	LANG=C.UTF-8 \
	WORKON_HOME="/.venv" \
	USER="api" \
	GROUP="api" \
	UID=1000 \
	GID=1000 \
	PYTHONUNBUFFERED=1 \
	LD_LIBRARY_PATH=/usr/local/lib64/:$LD_LIBRARY_PATH \
	POETRY_HOME="/usr/local/poetry" \
    POETRY_VERSION="1.0.3" \
    PATH="${PATH}:/.venv:/usr/local/poetry/bin"

RUN apk add --update --no-cache --virtual build-dependencies \
    python3-dev \
    build-base \
    linux-headers \
    libffi-dev \
    openssl-dev \
    curl \
 && addgroup -g ${GID} -S ${GROUP} \
 && adduser -u ${UID} -s /bin/sh -S ${USER} -G ${GROUP} -G wheel -D

WORKDIR /src/translator/translators/dummy/
COPY pyproject.toml poetry.lock setup.sh setup_poetry.sh ./

RUN chmod +x *.sh && ./setup.sh
COPY . ./

RUN apk del build-dependencies

USER ${USER}

# Set the virtualenv path for the api-user as well.
RUN python -m pip install --user --upgrade pip \
 && poetry config virtualenvs.in-project false \
 && poetry config virtualenvs.path "${WORKON_HOME}"

EXPOSE 8080

ENTRYPOINT ["sh", "./docker-entrypoint.sh"]
