import pytest
from Crypto.PublicKey import RSA

import settings
from application import application
from app.pytest_fixtures import (
    make_client,
    validate_signed_data,
    make_requests_mock,
    generate_signed_data,
)
from app.standards import DataType, get_context_url

key = RSA.generate(2048)
PRIVATE_KEY = key.export_key()
PUBLIC_KEY = key.publickey().export_key()


@pytest.fixture
def client():
    settings.PUBLIC_KEY = PUBLIC_KEY
    settings.PRIVATE_KEY = PRIVATE_KEY
    return make_client(application)


@pytest.fixture
def translator_controller_args():
    return {
        "@context": get_context_url("DataProductParametersSensor", "v2", base="pot"),
        "timestamp": "2020-06-03T12:01:01Z",
        "productCode": "dummy",
        "parameters": {
            "ids": [{"id": "exxample1"}, {"id": "example2"}],
            "startTime": "2020-02-10T13:06:40+00:00",
            "endTime": "2020-02-10T14:53:54+00:00",
            "dataTypes": [DataType.MeasureAirTemperatureCelsiusDegree.value],
        },
    }


@pytest.fixture
def translator_controller_required_args():
    return {
        "@context": get_context_url("DataProductParametersSensor", "v2", base="pot"),
        "timestamp": "2020-06-03T12:01:01Z",
        "productCode": "dummy",
        "parameters": {
            "ids": [{"id": "exxample1"}, {"id": "example2"}],
            "dataTypes": [DataType.MeasureAirTemperatureCelsiusDegree.value],
        },
    }


@pytest.fixture
def translator_controller_missing_required_args():
    return {}


@pytest.fixture
def translator_controller_args_invalid_rfc3339():
    return {
        "@context": get_context_url("DataProductParametersSensor", "v2", base="pot"),
        "timestamp": "2020-06-03U12:01:01Z",
        "productCode": "dummy",
        "parameters": {
            "ids": [{"id": "exxample1"}, {"id": "example2"}],
            "startTime": "2020-02-10U13:06:40+00:00",
            "endTime": "2020-02-10U14:53:54+00:00",
            "dataTypes": [DataType.MeasureAirTemperatureCelsiusDegree.value],
        },
    }


@pytest.fixture
def load_public_key(make_requests_mock):
    return make_requests_mock("app.translator.utils.load_public_key")


@pytest.fixture
def mock_rfc3339(make_requests_mock):
    return make_requests_mock("app.utils.rfc3339")


@pytest.fixture
def mock_utils_validate(make_requests_mock):
    return make_requests_mock("app.translator.utils.validate")
