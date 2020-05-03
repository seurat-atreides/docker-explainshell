container_name := docker-explainshell
docker_repository_url := index.docker.io
docker_org := seurat
GIT_BRANCH  = $(shell git rev-parse --abbrev-ref HEAD)
GIT_SHA     = $(shell git rev-parse HEAD)
BUILD_DATE  = $(shell date -u +"%Y-%m-%dT%H:%M:%SZ")
VERSION     ?= 1.0.0

TAG ?= $(VERSION)
ifeq ($(TAG),@branch)
	override TAG = $(shell git symbolic-ref --short HEAD)
	@echo $(value TAG)
endif

bash:
	docker run --rm -i -t --entrypoint "bash" $(docker_org)/$(container_name):latest -l
	
.PHONY: run
run:
	docker run --name explainshell-srv -p 5000:5000 -p 27017:27017 $(docker_repository_url)/$(docker_org)/$(container_name):latest
