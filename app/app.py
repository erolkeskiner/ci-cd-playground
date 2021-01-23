import logging

from flask import Flask, request
from flask_healthz import healthz

app = Flask(__name__)
app.register_blueprint(healthz, url_prefix="/healthz")
app.config.from_object("config.DevelopmentConfig")

logging.basicConfig(level=logging.DEBUG)


@app.route('/helloworld')
def hello_world():
    app.logger.info('Config:')
    app.logger.info(app.config)
    app.logger.info(app.config["HEALTHZ"])
    name = request.args.get('name', '')
    if name:
        return 'Hello {}!'.format(name)
    else:
        return 'Hello Stranger!'


# liveness and readiness functions may be developed in the future.
# Ex: testing any interaction with different component such as database
def liveness():
    return True


def readiness():
    return True


if __name__ == '__main__':
    app.run()
