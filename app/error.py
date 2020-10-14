"""
Custom error handler for the API.
"""
import json
from typing import Callable

from bottle import HTTPError, Bottle, template, tob, ERROR_PAGE_TEMPLATE, response


def make_custom_error_handler(debug=False) -> Callable[[HTTPError], str]:
    """Fabric function for creating HTTPError handler.

    :param debug: Display rendered traceback in case of exception
    :return: Bottle-acceptable HTTPError handler function
    """

    def custom_error_handler(error: HTTPError) -> str:
        """Defines the custom error handler for HTTPErrors.

        :param error: The HTTPError.
        :return: JSON string of the error.
        """
        if debug and error.traceback:
            return render_html_with_traceback(error)
        try:
            body = json.loads(error.body)
        except json.decoder.JSONDecodeError:
            body = error.body

        data = {"error": {"status": error.status_code, "message": body}}

        response.content_type = "application/json"
        return json.dumps(data)

    return custom_error_handler


def render_html_with_traceback(error: HTTPError) -> str:
    """Bottle's default error handler."""
    return tob(template(ERROR_PAGE_TEMPLATE, e=error))


def configure_http_error_handling(app: Bottle, debug=False):
    """Setup default HTTPError handler to Bottle application.

    :param app: Bottle application
    :param debug: Include traceback information in HTTP response
    """
    app.default_error_handler = make_custom_error_handler(debug)
    app.catchall = debug
