all: build

.PHONY: init
init:
	git submodule update --init --recursive

.PHONY: update-submodule
update-submodule: init
	# Fetch the latest tags
	cd swagger-ui && git fetch --tags
	# Get the latest tag
	$(eval LATEST_TAG := $(shell cd swagger-ui && git describe --tags `git rev-list --tags --max-count=1`))
	@echo "Latest tag for swagger-ui: $(LATEST_TAG)"
	# Checkout the latest tag
	cd swagger-ui && git checkout $(LATEST_TAG)
	@echo "Updated submodule swagger-ui to latest tag: ${LATEST_TAG}"

.PHONY: deps
deps:
	go install github.com/UnnoTed/fileb0x@v1.1.4

.PHONY: build
build:
	fileb0x fileb0x/b0x.yaml
