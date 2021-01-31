import re

from flask import Blueprint, request

hello_world_blueprint = Blueprint('hello_world', __name__)


@hello_world_blueprint.route('/helloworld')
def hello_world():
    full_name = request.args.get('name', '')
    if full_name:
        name_list = re.findall('[A-Za-z][^A-Z]*', full_name)
        response = 'Hello {}!'.format(" ".join(name_list))
    else:
        response = 'Hello Stranger!'
    return response
