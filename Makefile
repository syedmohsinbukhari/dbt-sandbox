IMAGE := dbt-sandbox


help: ## Get a description of what each command does
	@grep -h -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'


build:  ## Build docker image locally for development
	docker build -t $(IMAGE) -f Dockerfile .


run:  ## Run development environment for dbt-sandbox
	docker run -ti --rm $(IMAGE) /bin/bash
