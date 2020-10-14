"""
Application logger.
"""
import logging
import os
import sys


def get_logger(name: str = "api") -> logging.Logger:
    """Returns the configured logger.

    :param name: The logger name. Defaults to "api".
    :type name: str
    :return logging.Logger:
    """
    log = logging.getLogger(name)

    log.setLevel(logging.DEBUG)

    test_env = os.environ.get("ENV") == "unittest"
    # redirect output to stdout for avoiding CI fails due to stderr output
    handler = logging.StreamHandler(stream=sys.stdout if test_env else None)
    handler.setLevel(logging.DEBUG)

    formatter = logging.Formatter("[%(asctime)s] %(name)s [%(levelname)s]: %(message)s")

    handler.setFormatter(formatter)

    log.addHandler(handler)

    return log


logger = get_logger()
