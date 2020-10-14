from typing import Callable

import bottle
from webargs.bottleparser import use_args


def add_route(
    app: bottle.Bottle, path: str, method: str, handler: Callable, apply: list = None
):
    """Helper for avoiding explicitly pushing use_args
    function to Bottle app's middleware list
    """

    if apply is None:
        apply = []
    if hasattr(handler, "args"):
        apply.append(use_args(handler.args))
    app.route(path, method, handler, apply=apply)


def request_args(args):
    """Decorator for request arguments.

    Defines fields that should be passed to the controller action.

    :param args: The arguments of the request.
    :type args: dict
    :return: The function with params defined.
    """

    def _decorator(fn):
        fn.args = args
        return fn

    return _decorator
