"""
Application controllers are defined in this file.

The controllers handle all requests and routes, returns responses to consumers.
"""
import bottle
from marshmallow_enum import EnumField
from webargs import fields

import app
import app.services as services
import settings
from app.log import logger
from app.request_args import request_args
from app.request_args.fields import RFC3339DateTime, StartsWith
from app.responses import JSONResponse
from app.standards import DataType, get_context_url
from app.translator import productize_translator_response, validate_headers


class BaseController:
    """Base controller class.

    All controllers should derive from this class.
    """

    _app = None

    def __init__(self, app: bottle.Bottle = None):
        logger.debug(f"Controller: Base init. {self.__class__.__name__}")
        if app is not None:
            self._app = app

    def set_app(self, app: bottle.Bottle):
        """Sets the Bottle app for the controller.

        :param app: The Bottle application.
        :return: None
        """
        self._app = app


class Status(BaseController):
    """Status controller.

    Mainly used for health check endpoints, but can also add
    more status endpoints to the API.
    """

    @staticmethod
    def health_check() -> JSONResponse:
        """Returns 200 OK with empty object.

        Used for health checks.

        :return JSONResponse: Empty response.
        """
        return JSONResponse({})

    @staticmethod
    def exception_test():
        raise ValueError("Test ApplicationInsights")


class Translator(BaseController):
    """Translator controller.

    Handles fetching and returning of the data.
    """

    _service = None  # type: services.DummyService

    def __init__(self):
        """Initializes the translator controller"""
        super().__init__()
        self._service = services.DummyService()

    @request_args(
        {
            "@context": fields.Str(
                required=True,
                validate=StartsWith(
                    get_context_url("DataProductParametersSensor", "v2", base="pot")
                ),
            ),
            "timestamp": RFC3339DateTime(required=True),
            "productCode": fields.Str(required=True),
            "parameters": fields.Nested(
                {
                    "ids": fields.List(
                        fields.Nested({"id": fields.Str(required=True)}, required=True),
                        required=True,
                    ),
                    "startTime": RFC3339DateTime(required=False),
                    "endTime": RFC3339DateTime(required=False),
                    "dataTypes": fields.List(
                        EnumField(DataType, error=DataType.error_message()),
                        required=True,
                    ),
                },
                required=True,
            ),
        }
    )
    @validate_headers
    @productize_translator_response(
        "DataProductOutputSensor",
        "v2",
        "pot",
        settings.PRIVATE_KEY,
        settings.PUBLIC_KEY_URL,
    )
    def fetch_temperature(self, args: dict) -> list:
        """Returns the temperature data to the PoT Broker API.

        :param dict args: The arguments for the request.
        :return list: Product list
        """

        params = args["parameters"]

        start_time = params.get("startTime", app.utils.get_current_utc())
        end_time = params.get("endTime", app.utils.get_current_utc())

        ids = [item.get("id") for item in args["parameters"].get("ids")]

        items = self._service.get_temperature_results(start_time, end_time, ids)

        return items

    @request_args(
        {
            "@context": fields.Str(
                required=True,
                validate=StartsWith(
                    get_context_url("DataProductParametersSensor", "v2", base="pot")
                ),
            ),
            "timestamp": RFC3339DateTime(required=True),
            "productCode": fields.Str(required=True),
            "parameters": fields.Nested(
                {
                    "ids": fields.List(
                        fields.Nested({"id": fields.Str(required=True)}, required=True)
                    ),
                    "startTime": RFC3339DateTime(required=False),
                    "endTime": RFC3339DateTime(required=False),
                    "dataTypes": fields.List(
                        EnumField(DataType, error=DataType.error_message()),
                        required=True
                    ),
                },
                required=True,
            ),
        }
    )
    @validate_headers
    @productize_translator_response(
        "DataProductOutputSensor", "v2", "pot",
        settings.PRIVATE_KEY,
        settings.PUBLIC_KEY_URL,
    )
    def fetch_co2(self, args: dict) -> list:
        """Returns the CO2 data to the PoT Broker API.

        :param dict args: The arguments for the request.
        :return list: Product list
        """

        params = args["parameters"]

        start_time = params.get("startTime", app.utils.get_current_utc())
        end_time = params.get("endTime", app.utils.get_current_utc())

        ids = [item.get("id") for item in args["parameters"].get("ids")]

        items = self._service.get_co2_results(start_time, end_time, ids)

        return items

    @request_args(
        {
            "@context": fields.Str(
                required=True,
                validate=StartsWith(
                    get_context_url("DataProductParametersSensor", "v2", base="pot")
                ),
            ),
            "timestamp": RFC3339DateTime(required=True),
            "productCode": fields.Str(required=True),
            "parameters": fields.Nested(
                {
                    "ids": fields.List(
                        fields.Nested({"id": fields.Str(required=True)}, required=True)
                    ),
                    "startTime": RFC3339DateTime(required=False),
                    "endTime": RFC3339DateTime(required=False),
                    "dataTypes": fields.List(
                        EnumField(DataType, error=DataType.error_message()),
                        required=True
                    ),
                },
                required=True,
            ),
        }
    )
    @validate_headers
    @productize_translator_response(
        "DataProductOutputSensor", "v2", "pot",
        settings.PRIVATE_KEY,
        settings.PUBLIC_KEY_URL,
    )
    def fetch_humidity(self, args: dict) -> list:
        """Returns the humidity data to the PoT Broker API.

        :param dict args: The arguments for the request.
        :return list: Product list
        """

        params = args["parameters"]

        start_time = params.get("startTime", app.utils.get_current_utc())
        end_time = params.get("endTime", app.utils.get_current_utc())

        ids = [item.get("id") for item in args["parameters"].get("ids")]

        items = self._service.get_humidity_results(start_time, end_time, ids)

        return items

    @staticmethod
    def show_public_key() -> bottle.HTTPResponse:
        """Shows the translator public key."""
        return bottle.HTTPResponse(
            settings.PUBLIC_KEY, status=200, headers={"Content-Type": "text/plain"}
        )
