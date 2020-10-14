from app.utils import get_from_env

SERVER = get_from_env("SERVER", "wsgiref")
HOST = get_from_env("HOST", "0.0.0.0")
PORT = get_from_env("PORT", 8080, convert_to=int)
ENV = get_from_env("ENV")
DEBUG = get_from_env("DEBUG", False, convert_to=bool)
RELOAD = get_from_env("RELOAD", False, convert_to=bool)

TRANSLATOR_BASE_URL = get_from_env("TRANSLATOR_BASE_URL")
PUBLIC_KEY = get_from_env("PUBLIC_KEY")
PRIVATE_KEY = get_from_env("PRIVATE_KEY")

BROKER_PUBLIC_KEY_URL = get_from_env("BROKER_PUBLIC_KEY_URL")
