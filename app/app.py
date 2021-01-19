from flask import Flask

app = Flask(__name__)


@app.route('/helloworld')
def hello_world():
    return 'Hello Stranger!'
