HOST:=127.0.0.1
PORT:=8080
APP_DIR:=./app/
VENV_NAME:=venv
DOCKER_TAG:=web-app
DOCKER_CONTAINER_NAME:=web-app
VIRTUALENV:=$(shell command -v virtualenv 2> /dev/null)
DOCKER:=$(shell command -v docker 2> /dev/null)
PYTHON3:=$(shell command -v python3 2> /dev/null)
VENV_BIN_DIR:=$(VENV_NAME)/bin
REQUIREMENTS:=$(APP_DIR)requirements.txt


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
	@echo "Installations are checked"

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
	rm -rf $(APP_DIR)build/
	rm -rf $(APP_DIR)dist/
	rm -rf $(APP_DIR)*.egg-info

isort: activate-venv
	cd $(APP_DIR) && isort .

lint: activate-venv
	cd $(APP_DIR) && flake8


test: activate-venv clean
	cd $(APP_DIR) && python -m pytest

run: activate-venv
	cd $(APP_DIR) && python app.py

docker-build:
	cd $(APP_DIR) && $(DOCKER) build \
      --file=./Dockerfile.alpine \
      --build-arg PORT=$(PORT) \
      --tag=web-app .

docker-run: docker-rm-container
	$(DOCKER) run \
      --detach=false \
      --name=$(DOCKER_TAG) \
      --publish=$(PORT):$(PORT) \
      $(DOCKER_CONTAINER_NAME)

docker-rm-container:
	$(DOCKER) rm $(DOCKER_CONTAINER_NAME) || true