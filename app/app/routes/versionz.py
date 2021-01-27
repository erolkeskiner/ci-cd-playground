from flask import Blueprint, jsonify
import time, git, json

versionz_blueprint = Blueprint('versionz', __name__)


@versionz_blueprint.route('/versionz')
def versionz():
    start = time.time()
    repo = git.Repo(search_parent_directories=True)
    sha = repo.head.object.hexsha
    repository_name = repo.remotes.origin.url

    return jsonify(
        repository_name=repository_name,
        commit_hash=sha,
        request_query_time=time.time() - start
    )
