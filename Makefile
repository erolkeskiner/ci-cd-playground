HOST:=127.0.0.1
PORT:=8080
APP_DIR:=./app
CHART_DIR:=./deploy/helm-chart/flask-app/
VENV_NAME:=venv
DOCKER_TAG:=erolkeskiner/web-app
DOCKER_CONTAINER_NAME:=web-app
VIRTUALENV:=$(shell command -v virtualenv 2> /dev/null)
DOCKER:=$(shell command -v docker 2> /dev/null)
PYTHON3:=$(shell command -v python3 2> /dev/null)
HELM:=$(shell command -v helm 2> /dev/null)
VENV_BIN_DIR:=$(VENV_NAME)/bin
REQUIREMENTS:=$(APP_DIR)/requirements.txt


.DEFAULT_GOAL = help

help:
	@echo "----------------------------HELP------------------------------"
	# TODO
	@echo "--------------------------------------------------------------"

check-setup:
ifndef PYTHON3
	@echo "Please install python 3.6 or higher"
	@echo "Make sure that python is executable via python3 command"
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

install: check-setup
	$(VIRTUALENV) $(VENV_NAME) -p $(PYTHON3)
	( \
	source $(VENV_NAME)/bin/activate; \
	pip install -r $(REQUIREMENTS); \
	)

activate-venv:
	(source $(VENV_NAME)/bin/activate;)

clean-venv:
	rm -rf $(VENV_NAME)

clean:
	find . -name "*.pyc" -type f -delete
	find . -name "*.pyo" -type f -delete
	find . -name "coverage.xml" -type f -delete
	rm -rf $(APP_DIR)/build/
	rm -rf $(APP_DIR)/dist/
	rm -rf $(APP_DIR)/*.egg-info

isort:
	cd $(APP_DIR) && ../$(VENV_BIN_DIR)/isort .

lint-app:
	cd $(APP_DIR) && ../$(VENV_BIN_DIR)/pylint --exit-zero --load-plugins pylint_flask ./app

lint-chart:
	helm lint $(CHART_DIR)

lint-all: lint-app lint-chart

test: clean
	cd $(APP_DIR) && export FLASK_ENV=testing && ../$(VENV_BIN_DIR)/python -m pytest

coverage:
	cd $(APP_DIR) && export FLASK_ENV=testing  && ../$(VENV_BIN_DIR)/coverage run --source=./app/ -m pytest

coverage-report: coverage
	cd $(APP_DIR)  && ../$(VENV_BIN_DIR)/coverage report && ../$(VENV_BIN_DIR)/coverage xml

run:
	cd $(APP_DIR) && export FLASK_ENV=development && ../$(VENV_BIN_DIR)/python -m flask run --host=$(HOST) --port=$(PORT)

build:lint-app test
	$(VENV_BIN_DIR)/pip freeze
	cd $(APP_DIR) && ../$(VENV_BIN_DIR)/python setup.py install sdist bdist_wheel

docker-build: build
	cd $(APP_DIR) && $(DOCKER) build \
      --file=./Dockerfile.alpine \
      --build-arg PORT=$(PORT) \
      --tag=$(DOCKER_TAG) .

docker-run: docker-rm-container
	$(DOCKER) run \
      --detach=false \
      --name=$(DOCKER_CONTAINER_NAME) \
      --publish=$(PORT):$(PORT) \
      --env PORT=$(PORT) \
      $(DOCKER_TAG)

docker-rm-container:
	$(DOCKER) rm $(DOCKER_CONTAINER_NAME) || true