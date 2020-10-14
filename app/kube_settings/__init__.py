import importlib
import importlib.util
import inspect
import os
from typing import Any, Callable, List

from app.log import logger


class KubernetesParam:
    """
    Indicator for settings.py param that it's must be passed
    via kubernetes config.
    """

    NOT_SET = "<NOT_SET>"

    def __init__(self, dev_default: Any = NOT_SET, validators: List[Callable] = None):
        """
        :param dev_default: Will be applied in development environment
        even if it was not provided via Kubernetes
        """
        self.dev_default = dev_default
        self._validators = validators or []

    @property
    def default_provided(self):
        return self.dev_default != self.NOT_SET

    def validate(self, value: Any):
        """"Check if provided value passes all the defined validations"""

        for validator in self._validators:
            validator(value)


def apply_local_settings(
    local_settings_name: str = "settings_local", skip_for_test_env: bool = True
):
    """
    Import provided module name, fetch all the settings defined in
    global namespace as KubernetesParam instances and override them.

    If environment variable ENV is set either to "development"
    or "unittest" then default values is allowed and errors won't be raised.

    :param local_settings_name: Name of local settings module
    :param skip_for_test_env: If environment is unittest, then don't import
    local settings and just replace KubernetesParam instances with
    their default values
    :return:
    """
    caller_globals = inspect.currentframe().f_back.f_globals
    environment = os.environ.get("ENV")

    if skip_for_test_env and environment == "unittest":
        for name, value in caller_globals.items():
            if isinstance(value, KubernetesParam):
                if not value.default_provided:
                    raise ValueError(f"No default dev value for {name} was provided")
                else:
                    caller_globals[name] = value.dev_default
        return

    defaults_allowed = environment == "development"
    required_fields = [
        name
        for name, value in caller_globals.items()
        if isinstance(value, KubernetesParam)
    ]

    local_settings_module_exists = importlib.util.find_spec(local_settings_name)
    if local_settings_module_exists:
        settings_module = importlib.import_module(local_settings_name)
    else:
        return

    missing_fields = []
    for field in required_fields:
        field_in_settings = getattr(settings_module, field, None) is not None
        dev_default_provided = caller_globals[field].default_provided
        if not field_in_settings and (not defaults_allowed or not dev_default_provided):
            missing_fields.append(field)

    if missing_fields:
        fields_fmt = ", ".join(missing_fields)
        raise ValueError(f'Following settings must be defined: "{fields_fmt}"')

    for field in required_fields:
        local_settings_value = getattr(settings_module, field, None)
        if defaults_allowed and local_settings_value is None:
            new_value = caller_globals[field].dev_default
            logger.debug(f"Set {field} to default: {new_value}")
        else:
            try:
                caller_globals[field].validate(local_settings_value)
            except ValueError as exc:
                raise ValueError(f"Validation failed for {field}: {str(exc)}")
            new_value = local_settings_value
        caller_globals[field] = new_value
