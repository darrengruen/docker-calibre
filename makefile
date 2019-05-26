# This prevents any quirks between shell types
SHELL := /bin/bash

# Set some defaults for local development
TRAVIS_BRANCH ?= $(shell git rev-parse --abbrev-ref HEAD 2> /dev/null || echo "unstable")
TRAVIS_COMMIT ?= $(shell git rev-parse --short HEAD 2> /dev/null || echo "unstable")

app           ?= $(shell basename "${PWD}" | sed 's|docker-||g')
build_date    ?= $(shell date -u +%FT%T.%S%Z)
img           ?= ${ns}/${app}:${tag}
ns            ?= gruen
tag           ?= $(shell sed 's|/|_|g' <<< ${TRAVIS_BRANCH}) 

ifdef NOCACHE
	nocache     := --no-cache
endif
# This is used for pushing from CI

base = [0-9]{1,4}
match = ^(master|latest|${base}(.${base})?(.${base})?((-|_).*))?


.PHONY: build
build: lint
	docker build \
		${nocache} \
	  --build-arg BRANCH_NAME=${TRAVIS_BRANCH} \
	  --build-arg BUILD_DATE=${build_date} \
	  --build-arg COMMIT_SHA=${TRAVIS_COMMIT} \
	  -t ${img} .
	
.PHONY: clean
clean:
	docker rmi ${img}

.PHONY: lint
lint:
	docker run -i --rm hadolint/hadolint:latest < Dockerfile
	
.PHONY: push
push:
	[[ ${tag} =~ ${match} ]] && docker push ${img} || echo "No push, not a version tag"
	[[ ${tag} =~ ${match} ]] && docker push ${img} || echo "No push, not a version tag"

.PHONY: test
test: build
	docker run --rm \
		-v "${PWD}:/test" \
		-v /var/run/docker.sock:/var/run/docker.sock \
		--workdir /test \
		--name ${app}_container_structure_test \
		gcr.io/gcp-runtimes/container-structure-test:latest \
			test \
			--image ${img} \
			--config /test/test.yaml

ifndef VERBOSE
  .SILENT:
endif
