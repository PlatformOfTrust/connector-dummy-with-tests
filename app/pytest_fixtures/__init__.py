from functools import wraps
from unittest.mock import MagicMock

import bottle
import pytest
from app.log import logger
from webtest import TestApp, TestResponse


def patch_response(fn):
    @wraps(fn)
    def wrapper(*args, **kwargs):
        response = fn(*args, **kwargs)

        def is_ok():
            if response.status_code >= 400:
                raise ValueError(
                    f"API call: {bottle.request}, {kwargs}\n"
                    f"[{response.status_code}]\n{response.text}"
                )

            return True

        response.is_ok = is_ok
        return response

    return wrapper


class APIClient:
    def __init__(self, app: TestApp):
        self.app = app
        self._base_headers = {}

    @patch_response
    def get(self, url, params=None, headers: dict = None) -> TestResponse:
        headers = self._prepare_headers(headers)
        return self.app.get(url, params, headers, expect_errors=True)

    @patch_response
    def post(self, url, params=None, headers: dict = None) -> TestResponse:
        params = params or {}
        headers = self._prepare_headers(headers)
        return self.app.post_json(url, params, headers=headers, expect_errors=True)

    @patch_response
    def put(self, url, params=None, headers: dict = None) -> TestResponse:
        params = params or {}
        headers = self._prepare_headers(headers)
        return self.app.put_json(url, params, headers=headers, expect_errors=True)

    @patch_response
    def delete(self, url, params=None, headers: dict = None) -> TestResponse:
        params = params or {}
        headers = self._prepare_headers(headers)
        return self.app.delete_json(url, params, headers=headers, expect_errors=True)

    def _prepare_headers(self, headers: dict):
        result = self._base_headers.copy()
        if headers is not None:
            result.update(headers)
        return result

    def set_auth_token(self, token="FakeToken"):  # nosec
        self._base_headers["Authorization"] = f"Bearer {token}"


def make_client(application: bottle.Bottle, http_host: str = "unittest"):
    # For make cookies work https://github.com/Pylons/webtest/issues/84
    extra_environ = {"HTTP_HOST": http_host}
    return APIClient(TestApp(application, extra_environ))


@pytest.fixture
def make_requests_mock(monkeypatch):
    def wrapper(path: str):
        mocked_requests = MagicMock()
        for method in ("get", "post", "put", "delete"):
            getattr(mocked_requests, method).return_value = MagicMock(
                text="{}", status_code=200
            )
        monkeypatch.setattr(path, mocked_requests)
        return mocked_requests

    return wrapper


@pytest.fixture
def sign_token(monkeypatch):
    mocked_fn = MagicMock()
    monkeypatch.setattr("app.tokens.validate_signed_token", mocked_fn)
    return mocked_fn


@pytest.fixture
def validate_signed_data(monkeypatch):
    mocked_fn = MagicMock()
    monkeypatch.setattr("app.tokens.validate_signed_data", mocked_fn)
    return mocked_fn


@pytest.fixture
def generate_signed_data(monkeypatch):
    mocked_fn = MagicMock()
    monkeypatch.setattr("app.tokens.generate_signed_data", mocked_fn)
    return mocked_fn
