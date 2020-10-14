"""
Application services are defined in this file.

Services usually handle communication with the database if it exists, or
sending requests to other services.
"""
from datetime import datetime, timedelta, timezone

import settings
from app.standards import DataType


BASE_TEMPERATURE = 17
INCREMENT_TEMPERATURE = 0.5
BASE_CO2_LEVEL_PPM = 320
INCREMENT_CO2 = 8
BASE_HUMIDITY_LEVEL = 55
INCREMENT_HUMIDITY = 0.5


class DummyService:
    """Service service.

    Handles fetching of data depending on given parameters.
    """

    def get_temperature_results(
        self,
        start_time: datetime,
        end_time: datetime,
        ids: list,
    ) -> list:
        first_date = self.get_first_timestamp(start_time)
        measurements = []
        for site_name in ids:
            data = []
            current_date = first_date
            while current_date < end_time:
                timestamp = int(current_date.timestamp())
                temperature = self.get_dummy_value(
                    timestamp, site_name, BASE_TEMPERATURE, INCREMENT_TEMPERATURE
                )
                data.append(
                    {
                        "timestamp": datetime.fromtimestamp(
                            timestamp, timezone.utc
                        ).isoformat(timespec="seconds"),
                        "value": temperature,
                        "@type": DataType.MeasureAirTemperatureCelsiusDegree.value,
                    }
                )
                current_date += timedelta(minutes=30)

            measurements.append({"id": {"id": site_name}, "measurements": data})

        return measurements

    def get_co2_results(self, start_time: datetime, end_time: datetime, ids: list) -> list:
        first_date = self.get_first_timestamp(start_time)
        measurements = []
        for site_name in ids:
            data = []
            current_date = first_date
            while current_date < end_time:
                timestamp = int(current_date.timestamp())
                co2_level = self.get_dummy_value(
                    timestamp, site_name, BASE_CO2_LEVEL_PPM, INCREMENT_CO2
                )
                data.append(
                    {
                        "timestamp": datetime.fromtimestamp(
                            timestamp, timezone.utc
                        ).isoformat(timespec="seconds"),
                        "value": co2_level,
                        "@type": DataType.MeasureAirCO2LevelPPM.value,
                    }
                )
                current_date += timedelta(minutes=30)

            measurements.append({"id": {"id": site_name}, "measurements": data})

        return measurements

    def get_humidity_results(self, start_time: datetime, end_time: datetime, ids: list) -> list:
        first_date = self.get_first_timestamp(start_time)
        measurements = []
        for site_name in ids:
            data = []
            current_date = first_date
            while current_date < end_time:
                timestamp = int(current_date.timestamp())
                humidity = self.get_dummy_value(
                    timestamp, site_name, BASE_HUMIDITY_LEVEL, INCREMENT_HUMIDITY
                )
                data.append(
                    {
                        "timestamp": datetime.fromtimestamp(
                            timestamp, timezone.utc
                        ).isoformat(timespec="seconds"),
                        "value": humidity,
                        "@type": DataType.MeasureAirHumidity.value,
                    }
                )
                current_date += timedelta(minutes=30)

            measurements.append({"id": {"id": site_name}, "measurements": data})

        return measurements

    @staticmethod
    def get_first_timestamp(start_time: datetime) -> datetime:
        """
        Get the first timestamp after start_time that is a multiple of 30 minutes

        :param start_time: start time datetime
        :return:
        """
        floored_time = start_time.replace(
            minute=start_time.minute // 30 * 30, second=0, microsecond=0
        )
        return floored_time + timedelta(minutes=30)

    @staticmethod
    def get_dummy_value(
        timestamp: int,
        site_name: str,
        base: float,
        increment: float,
    ) -> float:
        """
        Get a dummy value based on timestamp and site_name using base and increment
        values for that type of data.

        :param timestamp: The timestamp for which the temperature must be computed
        :param site_name: The site_name/id
        :param base: The base value for this type of data
        :param increment: The increment value for this type of data
        :return:
        """
        # Remove las 2 digits because they are always 00 when going from 30 to 30
        # minutes
        timestamp /= 100

        # Take last digit
        last_digit = timestamp % 10

        result = base + increment * last_digit

        site_name_value = sum([ord(c) for c in site_name])
        site_name_last_digit = site_name_value % 10

        return result + increment * site_name_last_digit

