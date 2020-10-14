from typing import Optional

import bottle
from app.error import configure_http_error_handling
from app.log import logger


def setup_application(
    application: bottle.Bottle,
    debug: bool,
    env: str,
) -> bottle.Bottle:
    """
    Configure error handling based on environment and
    wrap a WSGI application into set of common middlewares.

    :param application: Bottle application
    :param debug: Whether running on debug environment
    :param env: "ENV" environment variable

    :return: Configured bottle application
    """
    configure_http_error_handling(application, debug)
    bottle.debug(debug)

    return application
