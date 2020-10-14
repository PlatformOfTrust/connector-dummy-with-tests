from app.kube_settings import KubernetesParam, apply_local_settings
from app.kube_settings.validators import check_pem_key

# One place to change the environment names.
ENV_DEVELOPMENT = "development"
ENV_STAGING = "staging"
ENV_PRODUCTION = "production"
ENV_SANDBOX = "sandbox"

# environment (production, staging, development, test)
ENV = ENV_DEVELOPMENT

# server backend (cherrypy, gunicorn, waitress, tornado, wsgiref, ...)
# if set to '', a default server backend will be used
SERVER = "wsgiref"

# define host
HOST = "0.0.0.0"
# define port
PORT = 8080

# debug error messages
DEBUG = KubernetesParam(dev_default=True)

# auto-reload
RELOAD = KubernetesParam(dev_default=True)

BROKER_PUBLIC_KEY_URL = KubernetesParam(dev_default=None)

TRANSLATOR_BASE_URL = KubernetesParam(dev_default="http://192.168.99.100:32000")

PUBLIC_KEY = KubernetesParam(dev_default=None, validators=[check_pem_key])
PRIVATE_KEY = KubernetesParam(dev_default=None, validators=[check_pem_key])

apply_local_settings(local_settings_name="settings_kube")
apply_local_settings()

PUBLIC_KEY_URL = f"{TRANSLATOR_BASE_URL}/dummy-translator/v1/public.key"
