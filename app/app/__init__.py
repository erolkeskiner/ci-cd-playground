import os

from flask import Flask, request
from flask_healthz import healthz


def create_app():
    app = Flask(__name__)
    app.register_blueprint(healthz, url_prefix="/healthz")

    flask_env = os.environ['FLASK_ENV']
    if flask_env == 'production':
        app.config.from_object("config.ProductionConfig")
    elif flask_env == 'testing':
        app.config.from_object("config.TestingConfig")
    else:
        app.config.from_object("config.DevelopmentConfig")

    @app.route('/')
    def welcome():
        return 'Greetings to the World!'

    @app.route('/helloworld')
    def hello_world():
        name = request.args.get('name', '')
        if name:
            return 'Hello {}!'.format(name)
        else:
            return 'Hello Stranger!'

    return app
