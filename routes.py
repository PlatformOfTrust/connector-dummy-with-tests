"""
Application routes are defined in this file.
"""
import bottle

import app.controllers
from app.request_args import add_route

# Instantiate the controllers here, for easy mocking.
status = app.controllers.Status()
translator = app.controllers.Translator()


def setup_routing(app: bottle.Bottle):
    for controller in (status,):
        controller.set_app(app)

    # Status
    add_route(app, "/health", "GET", status.health_check)
    add_route(app, "/health/exception-test", "GET", status.exception_test)

    # Translator
    add_route(app, "/fetch", "POST", translator.fetch_temperature)
    add_route(app, "/data/co2/fetch", "POST", translator.fetch_co2)
    add_route(app, "/data/humidity/fetch", "POST", translator.fetch_humidity)

    add_route(app, "/public.key", "GET", translator.show_public_key)
