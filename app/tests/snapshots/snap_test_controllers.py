# -*- coding: utf-8 -*-
# snapshottest: v1 - https://goo.gl/zC4yUc
from __future__ import unicode_literals

from snapshottest import Snapshot


snapshots = Snapshot()

snapshots["test_headers 1"] = {
    "error": {"message": 'Missing required header "x-pot-signature"', "status": 422}
}

snapshots["test_headers 2"] = {
    "error": {"message": 'Missing required header "x-pot-signature"', "status": 422}
}

snapshots["test_headers 3"] = {
    "error": {"message": 'Missing required header "x-pot-signature"', "status": 422}
}

snapshots["test_headers 4"] = {
    "error": {"message": 'Missing required header "x-app-token"', "status": 422}
}

snapshots["test_headers 5"] = {
    "error": {"message": 'Missing required header "x-app-token"', "status": 422}
}

snapshots["test_headers 6"] = {
    "error": {"message": 'Missing required header "x-app-token"', "status": 422}
}

snapshots["test_timestamp_validation_fail 1"] = {
    "error": {"message": "Request timestamp not within time frame.", "status": 422}
}

snapshots["test_timestamp_validation_fail 2"] = {
    "error": {"message": "Request timestamp not within time frame.", "status": 422}
}

snapshots["test_timestamp_validation_fail 3"] = {
    "error": {"message": "Request timestamp not within time frame.", "status": 422}
}

snapshots["test_fetch_temperature 1"] = {
    "sensors": [
        {
            "id": {"id": "exxample1"},
            "measurements": [
                {
                    "@type": "MeasureAirTemperatureCelsiusDegree",
                    "timestamp": "2020-02-10T13:30:00+00:00",
                    "value": 22.5,
                },
                {
                    "@type": "MeasureAirTemperatureCelsiusDegree",
                    "timestamp": "2020-02-10T14:00:00+00:00",
                    "value": 21.5,
                },
                {
                    "@type": "MeasureAirTemperatureCelsiusDegree",
                    "timestamp": "2020-02-10T14:30:00+00:00",
                    "value": 20.5,
                },
            ],
        },
        {
            "id": {"id": "example2"},
            "measurements": [
                {
                    "@type": "MeasureAirTemperatureCelsiusDegree",
                    "timestamp": "2020-02-10T13:30:00+00:00",
                    "value": 23.0,
                },
                {
                    "@type": "MeasureAirTemperatureCelsiusDegree",
                    "timestamp": "2020-02-10T14:00:00+00:00",
                    "value": 22.0,
                },
                {
                    "@type": "MeasureAirTemperatureCelsiusDegree",
                    "timestamp": "2020-02-10T14:30:00+00:00",
                    "value": 21.0,
                },
            ],
        },
    ]
}

snapshots["test_fetch_co2 1"] = {
    "sensors": [
        {
            "id": {"id": "exxample1"},
            "measurements": [
                {
                    "@type": "MeasureAirCO2LevelPPM",
                    "timestamp": "2020-02-10T13:30:00+00:00",
                    "value": 408.0,
                },
                {
                    "@type": "MeasureAirCO2LevelPPM",
                    "timestamp": "2020-02-10T14:00:00+00:00",
                    "value": 392.0,
                },
                {
                    "@type": "MeasureAirCO2LevelPPM",
                    "timestamp": "2020-02-10T14:30:00+00:00",
                    "value": 376.0,
                },
            ],
        },
        {
            "id": {"id": "example2"},
            "measurements": [
                {
                    "@type": "MeasureAirCO2LevelPPM",
                    "timestamp": "2020-02-10T13:30:00+00:00",
                    "value": 416.0,
                },
                {
                    "@type": "MeasureAirCO2LevelPPM",
                    "timestamp": "2020-02-10T14:00:00+00:00",
                    "value": 400.0,
                },
                {
                    "@type": "MeasureAirCO2LevelPPM",
                    "timestamp": "2020-02-10T14:30:00+00:00",
                    "value": 384.0,
                },
            ],
        },
    ]
}

snapshots["test_fetch_humidity 1"] = {
    "sensors": [
        {
            "id": {"id": "exxample1"},
            "measurements": [
                {
                    "@type": "MeasureAirHumidity",
                    "timestamp": "2020-02-10T13:30:00+00:00",
                    "value": 60.5,
                },
                {
                    "@type": "MeasureAirHumidity",
                    "timestamp": "2020-02-10T14:00:00+00:00",
                    "value": 59.5,
                },
                {
                    "@type": "MeasureAirHumidity",
                    "timestamp": "2020-02-10T14:30:00+00:00",
                    "value": 58.5,
                },
            ],
        },
        {
            "id": {"id": "example2"},
            "measurements": [
                {
                    "@type": "MeasureAirHumidity",
                    "timestamp": "2020-02-10T13:30:00+00:00",
                    "value": 61.0,
                },
                {
                    "@type": "MeasureAirHumidity",
                    "timestamp": "2020-02-10T14:00:00+00:00",
                    "value": 60.0,
                },
                {
                    "@type": "MeasureAirHumidity",
                    "timestamp": "2020-02-10T14:30:00+00:00",
                    "value": 59.0,
                },
            ],
        },
    ]
}

snapshots["test_fetch_temperature_rfc3339_validation_fail 1"] = {
    "error": {
        "message": {
            "parameters": {
                "endTime": ["Date must follow RFC3339 standard"],
                "startTime": ["Date must follow RFC3339 standard"],
            },
            "timestamp": ["Date must follow RFC3339 standard"],
        },
        "status": 422,
    }
}

snapshots["test_fetch_co2_rfc3339_validation_fail 1"] = {
    "error": {
        "message": {
            "parameters": {
                "endTime": ["Date must follow RFC3339 standard"],
                "startTime": ["Date must follow RFC3339 standard"],
            },
            "timestamp": ["Date must follow RFC3339 standard"],
        },
        "status": 422,
    }
}

snapshots["test_fetch_humidity_rfc3339_validation_fail 1"] = {
    "error": {
        "message": {
            "parameters": {
                "endTime": ["Date must follow RFC3339 standard"],
                "startTime": ["Date must follow RFC3339 standard"],
            },
            "timestamp": ["Date must follow RFC3339 standard"],
        },
        "status": 422,
    }
}

snapshots["test_fetch_temperature_only_required_fields 1"] = {
    "sensors": [
        {"id": {"id": "exxample1"}, "measurements": []},
        {"id": {"id": "example2"}, "measurements": []},
    ]
}

snapshots["test_fetch_co2_only_required_fields 1"] = {
    "sensors": [
        {"id": {"id": "exxample1"}, "measurements": []},
        {"id": {"id": "example2"}, "measurements": []},
    ]
}

snapshots["test_fetch_humidity_only_required_fields 1"] = {
    "sensors": [
        {"id": {"id": "exxample1"}, "measurements": []},
        {"id": {"id": "example2"}, "measurements": []},
    ]
}

snapshots["test_temperature_dataType_conversion 1"] = {
    "error": {
        "message": {"parameters": {"dataTypes": {"0": ['Invalid data type "wrong"']}}},
        "status": 422,
    }
}

snapshots["test_co2_dataType_conversion 1"] = {
    "error": {
        "message": {"parameters": {"dataTypes": {"0": ['Invalid data type "wrong"']}}},
        "status": 422,
    }
}

snapshots["test_humidity_dataType_conversion 1"] = {
    "error": {
        "message": {"parameters": {"dataTypes": {"0": ['Invalid data type "wrong"']}}},
        "status": 422,
    }
}

snapshots["test_temperature_context_fail 1"] = {
    "error": {
        "message": {
            "@context": [
                "Must start with "
                "https://standards.oftrust.net/v2/Context/DataProductParameters/Sensor/."
            ]
        },
        "status": 422,
    }
}

snapshots["test_co2_context_fail 1"] = {
    "error": {
        "message": {
            "@context": [
                "Must start with "
                "https://standards.oftrust.net/v2/Context/DataProductParameters/Sensor/."
            ]
        },
        "status": 422,
    }
}

snapshots["test_humidity_context_fail 1"] = {
    "error": {
        "message": {
            "@context": [
                "Must start with https://standards.oftrust.net/v2/Context/DataProductParameters/Sensor/."
            ]
        },
        "status": 422,
    }
}

snapshots["test_temperature_context_true 1"] = {
    "sensors": [
        {"id": {"id": "exxample1"}, "measurements": []},
        {"id": {"id": "example2"}, "measurements": []},
    ]
}

snapshots["test_co2_context_true 1"] = {
    "sensors": [
        {"id": {"id": "exxample1"}, "measurements": []},
        {"id": {"id": "example2"}, "measurements": []},
    ]
}

snapshots["test_humidity_context_true 1"] = {
    "sensors": [
        {"id": {"id": "exxample1"}, "measurements": []},
        {"id": {"id": "example2"}, "measurements": []},
    ]
}

snapshots["test_fetch_required_attributes 1"] = {
    "error": {
        "message": {
            "@context": ["Missing data for required field."],
            "parameters": {
                "dataTypes": ["Missing data for required field."],
                "ids": ["Missing data for required field."],
            },
            "productCode": ["Missing data for required field."],
            "timestamp": ["Missing data for required field."],
        },
        "status": 422,
    }
}
