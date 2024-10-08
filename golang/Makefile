# Import environment file
include .env
# Source all variables in environment file
# This only runs in the make command shell
# so won't muddy up, e.g. your login shell
export $(shell sed 's/=.*//' .env)
# Commands run in order by default when make invoked without arguments
# all: clean push-all
all: build-all
# (Performance optimization) List which targets don't produce a file with the same name as the target
.PHONY: clean build-all push-all

clean:
	rm docker-buildx-init

docker-buildx-init:
	docker buildx create
	# Create a file with the same name as this target so we only create
	# a builder image once per environment (i.e. laptop, jenkins)
	touch docker-buildx-init
	docker buildx ls

build-all: docker-buildx-init
	docker buildx build --platform linux/arm64,linux/amd64 --tag tozny/golang:1.22.8-alpine3.19 ./

push-all: docker-buildx-init
	docker buildx build --push --platform linux/arm64,linux/amd64 --tag tozny/golang:1.22.8-alpine3.19  ./

# Don't export to shell to keep stable per invoke of make / prevent dynamic interpolation
# Variables used to uniquely tag docker builds
export TIMESTAMP=$(shell date +%s)
export GIT_SHORT_HASH=$(shell echo $(shell git rev-parse HEAD) | cut -c 1-8)
IMAGE_TAG=$(GIT_SHORT_HASH)-$(TIMESTAMP)

publish:
	docker build --no-cache --tag tozny/golang:$(IMAGE_TAG) ./
	docker push tozny/golang:$(IMAGE_TAG)
