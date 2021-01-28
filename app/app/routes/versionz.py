import json
import time

from flask import Blueprint, jsonify

versionz_blueprint = Blueprint('versionz', __name__)


@versionz_blueprint.route('/versionz')
def versionz():
    start = time.time()
    try:
        with open('git-info.json', 'r') as f:
            info = json.loads(f.read())
    except FileNotFoundError:
        info = {}

    return jsonify(
        info=info,
        request_query_time=time.time() - start
    )
