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
