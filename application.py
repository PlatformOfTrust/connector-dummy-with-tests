"""
Main application.
"""
import bottle
import routes
import settings
from app.utils import repr_setting
from app.log import logger

from app.middlewares import setup_application

application = bottle.Bottle()
routes.setup_routing(application)

application = setup_application(
    application,
    debug=settings.DEBUG,
    env=settings.ENV,
)

logger.info(
    f"""
    Translator settings:
    {repr_setting(settings, "SERVER")}
    {repr_setting(settings, "HOST")}
    {repr_setting(settings, "PORT")}
    {repr_setting(settings, "RELOAD")}
    {repr_setting(settings, "DEBUG")}
    """
)

if __name__ == "__main__":
    bottle.run(
        application,
        server=settings.SERVER,
        host=settings.HOST,
        port=settings.PORT,
        reloader=settings.RELOAD,
    )
