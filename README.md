# CI/CD Playground

This repository is intended to create a basic Flask Web Application and to create related CI/CD pipelines using Minikube, Helm, Jenkins and Terraform.

## Introduction

This project walks through implementing a simple CI/CD pipeline for a Python Flask application. The following is demonstrated:

- Integrating Jenkins with a GitHub project
- Implementing a CI/CD pipeline using a Jenkinsfile
- Testing and running static code analysis, publishing related reports to the Jenkins Pipeline
- Building the Python package
- Building the Docker image using the Python package
- Publishing the Docker image to Docker Hub
- Deploying the Docker image to a K8s cluster


## Prerequisites
Before you get started you'll need to have these:

- [GitHub Account](https://github.com/)
- [Docker Hub Account](https://hub.docker.com/) or any other public/private Docker Image Registry Account
- A local or remote Jenkins server. In this project, a local installation used. Refer [here](https://github.com/erolkeskiner/ci-cd-playground/blob/main/local-installations/jenkins/HOW_TO_MACOS.md) for the local installation instructions and the configuration for this project
- A local or remote K8s cluster. In this project, [Minikube](https://minikube.sigs.k8s.io/docs/start/) used for a local K8s cluster installation. If you will also use the Minikube, you'll need a container or virtual machine manager, such as: [Docker](https://minikube.sigs.k8s.io/docs/drivers/docker/), [Hyperkit](https://minikube.sigs.k8s.io/docs/drivers/hyperkit/), [Hyper-V](https://minikube.sigs.k8s.io/docs/drivers/hyperv/), [KVM](https://minikube.sigs.k8s.io/docs/drivers/kvm2/), [Parallels](https://minikube.sigs.k8s.io/docs/drivers/parallels/), [Podman](https://minikube.sigs.k8s.io/docs/drivers/podman/), [VirtualBox](https://minikube.sigs.k8s.io/docs/drivers/virtualbox/), or [VMWare](https://minikube.sigs.k8s.io/docs/drivers/vmware/)
- [Python](https://www.python.org/downloads/) Version >= 3.6
- Fork then clone the [ci-cd-playground](git@github.com:erolkeskiner/ci-cd-playground.git) repository

## Project Structure

```
.
├── Jenkinsfile
├── Makefile
├── README.md
├── app
│   ├── app
│   │   ├── __init__.py
│   │   ├── routes
│   │   │   ├── __init__.py
│   │   │   ├── base_routes.py
│   │   │   ├── hello_world.py
│   │   │   ├── versionz.py
│   │   │   └── welcome.py
│   │   └── tests
│   │       ├── conftest.py
│   │       └── test_app.py
│   ├── Dockerfile.alpine
│   ├── MANIFEST.in
│   ├── README.md
│   ├── config.py
│   ├── gunicorn-config.py
│   ├── logging-config.json
│   ├── pylintrc
│   ├── requirements.txt
│   ├── setup.py
│   └── target-version.json
├── deploy
│   ├── helm-chart
│   │   ├── flask-app
│   │   │   ├── Chart.yaml
│   │   │   ├── templates
│   │   │   │   ├── NOTES.txt
│   │   │   │   ├── _helpers.tpl
│   │   │   │   ├── deployment.yaml
│   │   │   │   ├── hpa.yaml
│   │   │   │   ├── ingress.yaml
│   │   │   │   ├── service.yaml
│   │   │   │   └── tests
│   │   │   │       └── test-connection.yaml
│   │   │   └── values.yaml
│   │   ├── dev-overrides.yaml
│   │   ├── prod-overrides.yaml
│   │   └── rc-overrides.yaml
│   └── terraform
│       ├── dev.tfvars
│       ├── prod.tfvars
│       ├── rc.tfvars
│       ├── helm-release.tf
│       ├── init.tf
│       ├── namespace.tf
│       └── variables.tf
└── local-installations
    └── jenkins
        ├── HOW_TO_MACOS.md
        └── img
            ├── credentials.png
            ├── global_env_vars.png
            └── mb_pipeline_configuration.png
```

`app` directory contains the source code and configuration files of the application.

`deploy` directory contains the Helm Chart and the Terraform configuration files to deploy the application to a K8s cluster.

`local-installations` directory contains related documents to refer for installing and configuring Jenkins server.