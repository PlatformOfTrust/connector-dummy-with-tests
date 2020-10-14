"""
Helper functions to work with standards.oftrust.net
"""

from enum import Enum

LE_BASE_URL = "https://standards.lifeengine.io"
POT_BASE_URL = "https://standards.oftrust.net"

CONTEXT_MAP = {"MemberOf": "Context/Link/Role/MemberOf/"}

DATA_PRODUCT_CONTEXT_MAP = {
    "DataProductParametersSensor": "Context/DataProductParameters/Sensor",
    "DataProductOutputSensor": "Context/DataProductOutput/Sensor",
}

SENSOR_DATA_PRODUCT_CONTEXTS = [
    "DataProductParametersSensor",
    "DataProductOutputSensor",
]


class DataType(Enum):
    MeasureAirCO2LevelPPM = "MeasureAirCO2LevelPPM"
    MeasureAirTemperatureCelsiusDegree = "MeasureAirTemperatureCelsiusDegree"
    MeasurePresence = "MeasurePresence"
    MeasureAirHumidity = "MeasureAirHumidity"

    @staticmethod
    def error_message():
        return 'Invalid data type "{input}"'


def get_context_url(name: str, version: str = "v1", base: str = "pot") -> str:
    base_url = POT_BASE_URL

    if base is "le":
        base_url = LE_BASE_URL

    return f"{base_url}/{version}/{DATA_PRODUCT_CONTEXT_MAP[name]}/"
