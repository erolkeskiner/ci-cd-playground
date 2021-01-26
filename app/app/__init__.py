import logging
import os

from flask import Flask, request
from flask_healthz import healthz

from .routes.hello_world import hello_world_blueprint
from .routes.welcome import welcome_blueprint

def create_app():
    app = Flask(__name__)
    app.register_blueprint(healthz, url_prefix="/healthz")
    app.register_blueprint(welcome_blueprint)
    app.register_blueprint(hello_world_blueprint)

    flask_env = os.environ['FLASK_ENV']
    if flask_env == 'production':
        app.config.from_object("config.ProductionConfig")
    elif flask_env == 'testing':
        app.config.from_object("config.TestingConfig")
    else:
        app.config.from_object("config.DevelopmentConfig")

    gunicorn_logger = logging.getLogger('gunicorn.error')
    app.logger.handlers = gunicorn_logger.handlers
    app.logger.setLevel(gunicorn_logger.level)

    @app.after_request
    def log_after_request(response):
        app.logger.info('{} {} {}'.format(request.method, request.full_path, response.status))
        return response

    return app
