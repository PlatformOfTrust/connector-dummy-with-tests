"""
Application exceptions are found in this file.

All HTTP exceptions sets the content-type to JSON by default.
All HTTP exceptions are derived from the Bottle HTTPResponse class.
"""
import json

from bottle import HTTPResponse, HTTPError


class BaseResponse(HTTPResponse):
    """Base HTTPResponse class.

    Sets the content-type header and standardizes the error message.
    """

    def __init__(self, body="", status=400, headers=None, **more_headers):
        """Base response exception.

        All exception responses should be derived from this base class.

        :param body: The body of the response.
        :type body: str|dict
        :param status: The HTTP status. Defaults to 400 Bad Request.
        :type status: int
        :param headers: Response headers.
        :type headers: dict
        :param more_headers: Additional headers.
        :type more_headers: dict
        """
        if headers is None:
            headers = dict()

        if "Content-type" not in headers:
            headers = {"Content-type": "application/json"}

        _body = {"error": {"status": status, "message": body}}
        super().__init__(json.dumps(_body), status, headers, **more_headers)


class ValidationFailed(BaseResponse):
    """Validation exception.

    If the validation of arguments fails, this exception is raised.
    """

    def __init__(self, body="", status=422, headers=None, **more_headers):
        """Validation failed response.

        :param body: The body of the response.
        :type body: str|dict
        :param status: The HTTP status. Defaults to 422.
        :type status: int
        :param headers: Response headers.
        :type headers: dict
        :param more_headers: Additional headers.
        :type more_headers: dict
        """
        super().__init__(body, status, headers, **more_headers)


class NotFound(BaseResponse):
    """Not found exception.

    If a record is not found in the database, this exception is raised.
    """

    def __init__(self, body="", status=404, headers=None, **more_headers):
        """Not Found response.

        :param body: The body of the response.
        :type body: str|dict
        :param status: The HTTP status. Defaults to 404.
        :type status: int
        :param headers: Response headers.
        :type headers: dict
        :param more_headers: Additional headers.
        :type more_headers: dict
        """
        super().__init__(body, status, headers, **more_headers)


class FatalError(BaseResponse):
    """Fatal error exception.

    If something unrecoverable happens, this exception is raised.
    """

    def __init__(self, body="", status=500, headers=None, **more_headers):
        """Fatal Error response.

        :param body: The body of the response.
        :type body: str|dict
        :param status: The HTTP status. Defaults to 500.
        :type status: int
        :param headers: Response headers.
        :type headers: dict
        :param more_headers: Additional headers.
        :type more_headers: dict
        """
        super().__init__(body, status, headers, **more_headers)


class Forbidden(BaseResponse):
    """Forbidden exception.

    If a user doesn't have access to a resource/record, this exception is
    raised.
    """

    def __init__(self, body="", status=403, headers=None, **more_headers):
        """Forbidden response.

        :param body: The body of the response.
        :type body: str|dict
        :param status: The HTTP status. Defaults to 403.
        :type status: int
        :param headers: Response headers.
        :type headers: dict
        :param more_headers: Additional headers.
        :type more_headers: dict
        """
        super().__init__(body, status, headers, **more_headers)


class CreateError(BaseResponse):
    """Create error.

    Raised if creating of a record fails.
    """

    def __init__(self, body="", status=422, headers=None, **more_headers):
        """Create Error response.

        :param body: The body of the response.
        :type body: str|dict
        :param status: The HTTP status. Defaults to 403.
        :type status: int
        :param headers: Response headers.
        :type headers: dict
        :param more_headers: Additional headers.
        :type more_headers: dict
        """
        super().__init__(body, status, headers, **more_headers)


class UpdateError(BaseResponse):
    """Update error.

    Raised if updating of a record fails.
    """

    def __init__(self, body="", status=422, headers=None, **more_headers):
        """Update Error response.

        :param body: The body of the response.
        :type body: str|dict
        :param status: The HTTP status. Defaults to 403.
        :type status: int
        :param headers: Response headers.
        :type headers: dict
        :param more_headers: Additional headers.
        :type more_headers: dict
        """
        super().__init__(body, status, headers, **more_headers)


class DeleteError(BaseResponse):
    """Delete error.

    Raised if deleting a record fails.
    """

    def __init__(self, body="", status=422, headers=None, **more_headers):
        """Delete Error response.

        :param body: The body of the response.
        :type body: str|dict
        :param status: The HTTP status. Defaults to 403.
        :type status: int
        :param headers: Response headers.
        :type headers: dict
        :param more_headers: Additional headers.
        :type more_headers: dict
        """
        super().__init__(body, status, headers, **more_headers)


class RequestError(BaseResponse):
    """Request error.

    Raised if there's an error with the request to another API.
    """

    def __init__(self, body="", status=422, headers=None, **more_headers):
        """Request Error response.

        :param body: The body of the response.
        :type body: str|dict
        :param status: The HTTP status. Defaults to 403.
        :type status: int
        :param headers: Response headers.
        :type headers: dict
        :param more_headers: Additional headers.
        :type more_headers: dict
        """
        super().__init__(body, status, headers, **more_headers)


class InvalidRoleError(BaseResponse):
    """Invalid role error.

    Raised if a given user role is not supported.
    """

    def __init__(self, body="", status=422, headers=None, **more_headers):
        """Invalid Role Error response.

        :param body: The body of the response.
        :type body: str|dict
        :param status: The HTTP status. Defaults to 403.
        :type status: int
        :param headers: Response headers.
        :type headers: dict
        :param more_headers: Additional headers.
        :type more_headers: dict
        """
        super().__init__(body, status, headers, **more_headers)


class InvalidOrMissingHeader(BaseResponse):
    """Invalid or missing header.

    Raised if a required header is missing or is invalid.
    """

    def __init__(self, body="", status=422, headers=None, **more_headers):
        """Invalid Or Missing Header response.

        :param body: The body of the response.
        :type body: str|dict
        :param status: The HTTP status. Defaults to 403.
        :type status: int
        :param headers: Response headers.
        :type headers: dict
        :param more_headers: Additional headers.
        :type more_headers: dict
        """
        super().__init__(body, status, headers, **more_headers)


class InvalidUrl(BaseResponse):
    """Invalid URL.

    Raised if a URL is invalid.
    """

    def __init__(self, body="", status=422, headers=None, **more_headers):
        """Invalid URL response.

        :param body: The body of the response.
        :type body: str|dict
        :param status: The HTTP status. Defaults to 403.
        :type status: int
        :param headers: Response headers.
        :type headers: dict
        :param more_headers: Additional headers.
        :type more_headers: dict
        """
        super().__init__(body, status, headers, **more_headers)


# HTTP Errors.


class ValidationError(HTTPError):
    """Validation Error.

    Raised when validation fails. Not to be mixed with ValidationFailed
    response.
    """

    def __init__(self, body="", status=422, exception=None, traceback=None, **options):
        """Validation Error error.

        :param body: The body/message of the error.
        :type body: str|dict
        :param status: The HTTP status. Defaults to 422.
        :type status: int
        :param exception: The exception.
        :type exception: Exception
        :param traceback: The backtrace of the exception.
        :type traceback: str
        :param options: Additional options.
        :type options: dict
        """
        super().__init__(status, body, exception, traceback, **options)


class MissingRequiredHeaderError(HTTPError):
    """Missing Required Header Error.

    Raised if a required header is missing.
    """

    def __init__(self, body="", status=422, exception=None, traceback=None, **options):
        """Missing Required Header Error error.

        :param body: The body/message of the error.
        :type body: str|dict
        :param status: The HTTP status. Defaults to 422.
        :type status: int
        :param exception: The exception.
        :type exception: Exception
        :param traceback: The backtrace of the exception.
        :type traceback: str
        :param options: Additional options.
        :type options: dict
        """
        super().__init__(status, body, exception, traceback, **options)


class ModelError(HTTPError):
    """Model error.

    If there's errors with a record model, this exception is raised.
    """

    def __init__(self, body="", status=500, exception=None, traceback=None, **options):
        """Model error.

        :param body: The body/message of the error.
        :type body: str|dict
        :param status: The HTTP status. Defaults to 500.
        :type status: int
        :param exception: The exception.
        :type exception: Exception
        :param traceback: The backtrace of the exception.
        :type traceback: str
        :param options: Additional options.
        :type options: dict
        """
        super().__init__(status, body, exception, traceback, **options)


class RemoteServiceError(HTTPError):
    """Remote service error.

    Whenever there's an error with requesting a remote service.
    """

    def __init__(
        self,
        body="Remote service error",
        status=500,
        exception=None,
        traceback=None,
        **options
    ):
        """Remote service error.

        :param body: The body/message of the error.
        :type body: str|dict
        :param status: The HTTP status. Defaults to 500.
        :type status: int
        :param exception: The exception.
        :type exception: Exception
        :param traceback: The backtrace of the exception.
        :type traceback: str
        :param options: Additional options.
        :type options: dict
        """
        super().__init__(status, body, exception, traceback, **options)
