
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
	docker buildx build $(BUILD_ARGS) --platform linux/arm64,linux/amd64 --tag tozny/keycloak:26.8.0-alpha.1 ./

build: docker-buildx-init
	docker buildx build $(BUILD_ARGS) --platform linux/amd64 --tag tozny/keycloak:26.8.0-alpha.1 ./

push-all: docker-buildx-init
	docker buildx build $(BUILD_ARGS) --push --platform linux/arm64,linux/amd64 --tag tozny/keycloak:26.8.0-alpha.1 ./


# Don't export to shell to keep stable per invoke of make / prevent dynamic interpolation
# Variables used to uniquely tag docker builds
export TIMESTAMP=$(shell date +%s)
export GIT_SHORT_HASH=$(shell echo $(shell git rev-parse HEAD) | cut -c 1-8)
IMAGE_TAG=$(GIT_SHORT_HASH)-$(TIMESTAMP)

# The Dockerfile clones $GIT_BRANCH in a RUN layer, which Docker keys on the
# instruction text -- new commits on the branch do NOT invalidate it, so a plain
# rebuild silently ships stale source. Run `make build FRESH=1` to force a fresh
# clone: it re-runs the clone layer and everything after it (including the maven
# build) while leaving the yum layers above it, and every other project's build
# cache, untouched. Without FRESH the value stays constant and builds cache as usual.
CACHEBUST ?= 0
ifdef FRESH
CACHEBUST := $(TIMESTAMP)
endif
BUILD_ARGS=--build-arg CACHEBUST=$(CACHEBUST)

hotfix:
	docker build --no-cache --tag tozny/keycloak:hotfix-$(IMAGE_TAG) ./
	docker push tozny/keycloak:hotfix-$(IMAGE_TAG)
