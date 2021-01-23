from os import environ
from flask import Flask, request
from flask_healthz import healthz

app = Flask(__name__)
app.register_blueprint(healthz, url_prefix="/healthz")

if environ['FLASK_ENV'] == 'production':
    app.config.from_object("config.ProductionConfig")
elif environ['FLASK_ENV'] == 'testing':
    app.config.from_object("config.TestingConfig")
else:
    app.config.from_object("config.DevelopmentConfig")


@app.route('/helloworld')
def hello_world():
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
