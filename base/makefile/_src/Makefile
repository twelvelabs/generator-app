.DEFAULT_GOAL := help
SHELL := /bin/bash

# Via https://www.thapaliya.com/en/writings/well-documented-makefiles/
# TL;DR:
# - The `##` comments following the target name are the description.
# - The `##@` comments create a group header.
# - Targets that do not have a `##` comment will not be displayed.
.PHONY: help
help:
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
	@echo ""


##@ Develop

.PHONY: setup
setup: ## Setup dependencies
	@bin/setup.sh

.PHONY: lint
lint: ## Lint the app
	@bin/lint.sh

.PHONY: format
format: ## Format the app
	@bin/format.sh

.PHONY: run
run: ## Run the app
	@bin/run.sh

.PHONY: test
test: ## Test the app
	@bin/test.sh

.PHONY: coverage
coverage: ## Show test coverage
	@bin/coverage.sh

.PHONY: docs
docs: ## Generate documentation
	@bin/docs.sh

