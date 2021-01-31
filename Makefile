HOST:=127.0.0.1
PORT:=8000
VENV_NAME:=venv
DOCKER_TAG:=erolkeskiner/web-app
DOCKER_CONTAINER_NAME:=web-app
VIRTUALENV:=$(shell command -v virtualenv 2> /dev/null)
DOCKER:=$(shell command -v docker 2> /dev/null)
PYTHON3:=$(shell command -v python3 2> /dev/null)
HELM:=$(shell command -v helm 2> /dev/null)
VENV_BIN_DIR:=$(VENV_NAME)/bin
REQUIREMENTS:=./app/requirements.txt


.DEFAULT_GOAL = help

help: ##		Displays this message
	@echo "----------------------------HELP------------------------------"
	@echo "--------------------------------------------------------------"
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##		/\n	/'
	@echo "--------------------------------------------------------------"
	@echo "Usage examples with variables:"
	@echo "	HOST"
	@echo "		Ex: make run -e HOST=0.0.0.0"
	@echo "	PORT"
	@echo "		Ex: make run -e PORT=8080"
	@echo "	VENV_NAME"
	@echo "		Ex: make install -e VENV_NAME=env"
	@echo "	DOCKER_TAG"
	@echo "		Ex: make docker-build -e DOCKER_TAG=my-tag"
	@echo "	DOCKER_CONTAINER_NAME"
	@echo "		Ex: make docker-run -e DOCKER_CONTAINER_NAME=my-container"
	@echo "--------------------------------------------------------------"
	@echo "--------------------------------------------------------------"

check-setup: ##		Checks local installations to develop, build and deploy the application
ifndef PYTHON3
	@echo "Please install python 3.6 or higher"
	@echo "Make sure that python3 executable is defined in the PATH variable"
endif
ifndef VIRTUALENV
	@echo "virtualenv is not available, please install it.."
endif
ifndef DOCKER
	@echo "docker is not available, please install it.."
endif
ifndef HELM
	@echo "helm is not available, please install it.."
endif

install: ##		Creates a virtaulenv and installs the dependencies for local development
	$(VIRTUALENV) $(VENV_NAME) -p $(PYTHON3)
	( \
	source $(VENV_NAME)/bin/activate; \
	pip install -r $(REQUIREMENTS); \
	)

activate-venv: ##		Activates the virtualenv
	(source $(VENV_NAME)/bin/activate;)

clean-venv: ##		Removes the virtualenv directory
	rm -rf $(VENV_NAME)

clean: ##		Removes the output files of some other targets
	find . -name "*.pyc" -type f -delete
	find . -name "*.pyo" -type f -delete
	find . -name "coverage.xml" -type f -delete
	rm -rf ./app/build/
	rm -rf ./app/dist/
	rm -rf ./app/*.egg-info

isort: ##		Sorts imports alphabetically, and automatically separated into sections and by type
	cd ./app && ../$(VENV_BIN_DIR)/isort .

lint-app:  ##		Runs the linter on the application codes
	cd ./app && ../$(VENV_BIN_DIR)/pylint --exit-zero --load-plugins pylint_flask ./app > pylint.log

lint-chart: ##		Runs the linter on the Helm Chart
	helm lint ./deploy/helm-chart/flask-app/

lint-all: lint-app lint-chart ##		Runs the lint-app  and lint-chart targets

test: clean ##		Runs the unit tests on the application codes
	cd ./app && export FLASK_ENV=testing && ../$(VENV_BIN_DIR)/python -m pytest

coverage: ##		Runs the coverage on the application codes
	cd ./app && export FLASK_ENV=testing  && ../$(VENV_BIN_DIR)/coverage run --source=./app/ -m pytest

coverage-report: coverage ##		Creates the unit test coverage report
	cd ./app  && ../$(VENV_BIN_DIR)/coverage report && ../$(VENV_BIN_DIR)/coverage xml

run: ##		Runs locally the application using 'flask' command
	cd ./app && export FLASK_ENV=development && ../$(VENV_BIN_DIR)/python -m flask run --host=$(HOST) --port=$(PORT)

build: ##		Builds the python package of the application
	cd ./app && ../$(VENV_BIN_DIR)/python setup.py install sdist bdist_wheel

docker-build: build ##		Builds the docker image containing the application
	cd ./app && $(DOCKER) build \
      --file=./Dockerfile.alpine \
      --build-arg PORT=$(PORT) \
      --tag=$(DOCKER_TAG) .

docker-run: docker-rm-container ##		Runs the docker image locally
	$(DOCKER) run \
      --detach=false \
      --name=$(DOCKER_CONTAINER_NAME) \
      --publish=$(PORT):$(PORT) \
      --env PORT=$(PORT) \
      $(DOCKER_TAG)

docker-rm-container: ##		Removes any remaining docker container
	$(DOCKER) rm $(DOCKER_CONTAINER_NAME) || true