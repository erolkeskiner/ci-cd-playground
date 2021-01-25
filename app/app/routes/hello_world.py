from flask import Blueprint, request

hello_world_blueprint = Blueprint('hello_world', __name__)


@hello_world_blueprint.route('/helloworld')
def hello_world():
    name = request.args.get('name', '')
    if name:
        response = 'Hello {}!'.format(name)
    else:
        response = 'Hello Stranger!'
    return response
