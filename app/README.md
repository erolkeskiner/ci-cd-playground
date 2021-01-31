# Usage Examples

`make install` 
    Create a virtualenv and install dependencies

`make run -e PORT=8000`
    Run the application locally using 'flask' command

`make docker-build -e DOCKER_TAG=my-tag` 
    Build a docker image with `my-tag` tag from the application

`make docker-run -e DOCKER_TAG=my-tag -e DOCKER_CONTAINER_NAME=my-container`
    Run the docker image locally

`make test` 
    Run unit tests

`make lint-app`
    Run linter on the application

`make isort`
    Sort imports alphabetically and group them

`make build`
    Build the Python package


