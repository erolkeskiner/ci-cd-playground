from os import environ

from flask import Flask, request

app = Flask(__name__)


@app.route('/helloworld')
def hello_world():
    name = request.args.get('name', '')
    if name:
        return 'Hello {}!'.format(name)
    else:
        return 'Hello Stranger!'


if __name__ == '__main__':
    app.run()
