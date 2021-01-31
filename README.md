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

## Project Structure

```
.
├── Jenkinsfile
├── Makefile
├── README.md
├── app/
├── deploy/
│   ├── helm-chart/
│   └── terraform/
└── local-installations/
    └── jenkins/
```

`app` directory contains the source code and configuration files of the application.

`deploy` directory contains the Helm Chart and the Terraform configuration files to deploy the application to a K8s cluster.

`local-installations` directory contains related documents to refer for installing and configuring Jenkins server.


## Workflow
On every pipeline execution, the code goes through the following steps:

1. Code is cloned from this repository, built, tested and analyzed for bugs and bad patterns.
2. A Docker Container Image is built then published to Docker Container Registry.
3. If all previous steps finished successfully, the pipeline is paused for the approval to continue to the deployment.
4. If approved, the container image is deployed in a fresh new container in related K8s namespace.

Targeted release version for the Python package and Docker image is set in the `target-version.json` file in the `app` directory.
Three tags were used as suffixes to separate the packages: dev (development), rc (release candidate), and no suffix (release).

- Any pipeline running from not main branches (a.k.a. feature/bug fix branches) builds the Python package and Docker image with the `<target-version>-dev-<uuid>` tag, then publishes the Docker image to registry and deploys it to `dev` namespace on the K8s cluster.
- Any pipeline running from the main branch builds the Python package and Docker image with the `<target-version>-rc-<uuid>` , then publishes the Docker image to registry and deploys it to `rc` namespace on the K8s cluster.
- Any pipeline running from git tag builds the Python package and Docker image with the `<target-version>` tag, then publishes the Docker image to registry and deploys it to `prod` namespace on the K8s cluster.


## Thoughts and Future Works
For a healthier SDLC:

- Make your developments in feature branches.
- Create short-lived branches.
- Commit often. 
- Run the pipeline to see failures fast, to test the deployment on K8s.
- Prevent merging unhealthy branches to main branch.

Expand the release version identification with [community standards](https://www.python.org/dev/peps/pep-0440/).

Add more stages between development, release candidate, and release. This is not necessary since this is a personal and one-person project. But, with a growing team, it would be better to have more controls before merging the feature branches to the main branch.

The CI/CD pipeline covered in this project is only for one application. Add some other units such as a database or another service that the app will communicate with and implement a mechanism for integration tests.

Test the Terraform configurations using a tool such as [kitchen](https://newcontext-oss.github.io/kitchen-terraform/)



