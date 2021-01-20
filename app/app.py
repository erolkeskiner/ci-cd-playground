from flask import Flask, request
from os import environ

app = Flask(__name__)


@app.route('/helloworld')
def hello_world():
    name = request.args.get('name', '')
    if name:
        return 'Hello {}!'.format(name)
    else:
        return 'Hello Stranger!'


if __name__ == '__main__':
    try:
        host = environ["FLASK_RUN_HOST"]
    except KeyError:
        host = '0.0.0.0'
    try:
        port = environ["FLASK_RUN_PORT"]
    except KeyError:
        port = '8080'
    app.run(host=host, port=port)
