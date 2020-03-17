# This makefile is designed to handle to common operations involved in developing, build, and testing ACM@UIUC Core

# BASE_PACKAGE should be the name of the go module
# REPO_ROOT will be used to build absolute paths during build or testing stages
BASE_PACKAGE := github.com/acm-uiuc/core
REPO_ROOT := $(shell git rev-parse --show-toplevel)

# Builds all binaries
.PHONY: all
all: core

# Build the ACM@UIUC Core binary
.PHONY: core
core:
	@echo 'Building ACM@UIUC Core'
	@mkdir -p $(REPO_ROOT)/bin
	@go build -o $(REPO_ROOT)/bin/core $(BASE_PACKAGE)
	@echo 'Finished'

# Runs all tests
.PHONY: test
test:
	@echo 'Testing ACM@UIUC Core'
	@IS_TEST=true DB_NAME=core-test go test -p 1 -count=1 github.com/acm-uiuc/core/test/...
	@echo 'Finished'

# Runs the existing binary
.PHONY: run
run:
	@echo 'Starting ACM@UIUC Core'
	@$(REPO_ROOT)/scripts/run.sh

# Formats the repo's golang files
.PHONY: fmt
fmt:
	@go fmt $(BASE_PACKAGE)/...
