"""All custom API param fields should be defined there."""
from copy import copy

import marshmallow as ma
import typing
from marshmallow import ValidationError
from marshmallow import missing
from marshmallow.fields import DateTime
from marshmallow.validate import Length, Validator

from app.utils import get_datetime_from_date_string


# Validators
class DateTimeValidator(Validator):
    def __call__(self, value: str):
        DateTime()._deserialize(value, "", {})


class StartsWith(Validator):
    """Validator which succeeds if the ``value`` passed to it is
    starts with ``comparable``.

    :param comparable: The object to compare to.
    :param error: Error message to raise in case of a validation error.
        Can be interpolated with `{input}` and `{other}`.
    """

    default_message = "Must start with {other}."

    def __init__(self, comparable, *, error: str = None):
        self.comparable = comparable
        self.error = error or self.default_message  # type: str

    def _repr_args(self) -> str:
        return "comparable={!r}".format(self.comparable)

    def _format_error(self, value) -> str:
        return self.error.format(input=value, other=self.comparable)

    def __call__(self, value) -> typing.Any:
        if not value.startswith(self.comparable):
            raise ValidationError(self._format_error(value))
        return value

# Fields
class SizeRestrictedString(ma.fields.String):
    """A size restricted string.

    Adds a length validator to the field.
    The MAX_LENGTH is mandatory.
    """

    MAX_LENGTH = None

    def __init__(self, *args, max_length: int = None, **kwargs):
        max_length = max_length or self.MAX_LENGTH
        if max_length is None:
            raise ValueError("Max length should be provided")
        validate = kwargs.get("validate", [])
        validate.append(Length(max=max_length))
        super().__init__(*args, **kwargs, validate=validate)


class ShortString(SizeRestrictedString):
    MAX_LENGTH = 128


class MediumLenString(SizeRestrictedString):
    MAX_LENGTH = 255


class LongString(SizeRestrictedString):
    MAX_LENGTH = 100000


class DateTimeString(ma.fields.String):
    def __init__(self, *args, **kwargs):
        validate = kwargs.get("validate", [])
        validate.append(DateTimeValidator())
        super().__init__(*args, **kwargs, validate=validate)


class UnixTimestamp(ma.fields.String):
    def _deserialize(self, value, attr, data, **kwargs):
        if not value:
            return value
        try:
            time = get_datetime_from_date_string(value)
        except ValueError:
            raise ValidationError("Date must follow RFC3339 standard")
        return int(time.timestamp())


class RFC3339DateTime(ma.fields.String):
    def _deserialize(self, value, attr, data, **kwargs):
        if not value:
            return value
        try:
            time = get_datetime_from_date_string(value)
        except ValueError:
            raise ValidationError("Date must follow RFC3339 standard")

        if not time.tzinfo:
            raise ValidationError("Date must contain timezone info")

        return time


class NestedDict(ma.fields.Dict):
    """A partially nested dict.

    This field works kind of like a Nested field, but will return all keys in
    the dict, and validates those that are specified as a field.
    """

    def __init__(self, nested: dict, *args, **kwargs):
        """Create the field.

        :param nested: A dictionary containing the fields we want to validate.
        :type nested: dict
        """
        self.nested = nested
        validate = kwargs.get("validate", [])
        super().__init__(*args, **kwargs, validate=validate)

    def _deserialize(self, value, attr, data):
        """Deserialize the nested dict.

        :param value: The actual value, e.g. the full dict containing all
        keys passed.
        :type value: dict
        :param attr: The attribute name. E.g. "data".
        :type attr: str
        :param data: The full data passed, including the root keys as well
        as the actual field under validation.
        :type data: dict
        :return: The value of the nested field, e.g. value.
        :rtype: dict
        :raise ValidationError: If the value is not a dict.
        """
        result = copy(value)
        if isinstance(result, dict):
            return result

        self.fail("validator_failed")

    def _validate_missing(self, value):
        """Validates the field.

        :param value: The value to validate.
        :type value: str|dict
        :raise ValidationError: If validation fails.
        """
        # Check all required nested fields.
        errors = self._check_required(value)
        # Validate the current nested field itself.
        if value is missing and hasattr(self, "required"):
            self.fail("required")
        elif errors:
            raise ValidationError(errors)
        else:
            super()._validate_missing(value)

    def _check_required(self, value):
        """Checks recursively the required fields.

        Runs _validate_missing on the field we want to validate.

        :param value: The actual dict we want to recursively check.
        :type value: dict
        :return: Any errors that the recursive validation generates.
        :rtype: dict
        """
        errors = {}
        # Loop through all the fields in the nested dict.
        for field_name, field in self.nested.items():
            if not field.required:
                continue

            error_field_name = field.load_from or field_name
            # Validate the nested field and the value for it.
            try:
                if isinstance(value, dict):
                    field_value = value.get(field_name, missing)
                else:
                    field_value = value

                field._validate_missing(field_value)
            except ValidationError as ve:
                errors[error_field_name] = ve.messages

        return errors
