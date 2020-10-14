"""
Application invoke tasks are defined in this file.

Tasks makes it easier to use the application.
"""
import shutil
from pathlib import Path
from invoke import task

# define projects directories
APP_DIR = Path(".")
API_DOCS_DIR = Path(f"{APP_DIR}/docs")
BLACK_CMD = "black . --exclude lib/python"


@task
def dev(ctx):
    """Run the application (use when developing)."""
    ctx.run("python application.py")


@task
def uwsgi(ctx):
    """Run the application with uwsgi (production)."""
    ctx.run(
        "uwsgi --http 0.0.0.0:8080 --processes 4"
        " --wsgi-file application.py --disable-logging"
    )


@task
def format_code(ctx):
    """Run the tests."""
    ctx.run(BLACK_CMD)


@task
def test(ctx):
    """Run the tests."""

    ctx.run(f"ENV=unittest python -m pytest -vv")


@task
def clean(ctx):
    """Clean any python generated files and folders."""
    for pattern in ["__pycache__", ".pytest_cache", "*.pyc", "*.pyo", "*~", "._*"]:
        for f in APP_DIR.rglob(pattern):
            if f.is_dir():
                print("Removing tree {}".format(f.name))
                shutil.rmtree(f)
            else:
                print("Removing file {}".format(f.name))
                f.unlink()


@task
def docs(ctx):
    """Generate the documentation for the API.

    :param ctx: The invoke context.
    :type ctx: invoke.Context
    :return: None
    :rtype: None
    :raise RuntimeError:
    """
    print("Generating documentation...")
    raml2html_path = Path(f"{APP_DIR.absolute()}/../../node_modules/.bin/raml2html")

    if not raml2html_path.exists():
        raise RuntimeError(
            "You need to install raml2html, use yarn install in the root."
        )

    with ctx.cd(f"{APP_DIR.absolute()}/../../"):
        ctx.run(
            f"yarn run -s generate "
            f"{API_DOCS_DIR.absolute()}/api.raml > "
            f"{API_DOCS_DIR.absolute()}/index.html"
        )

    print(f"Documentation generated to " f'"{API_DOCS_DIR}/index.html"')
