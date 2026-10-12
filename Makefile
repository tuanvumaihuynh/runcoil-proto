# Runcoil protocol: Buf lint and format, Go code generation, and checks.
# Tools run through `go run`, pinned by version. No global install is needed.

BUF_VERSION ?= v1.73.0
BUF = go run github.com/bufbuild/buf/cmd/buf@$(BUF_VERSION)

#########################
# Lint and format
#########################
.PHONY: lint
lint:
	$(BUF) lint

.PHONY: format
format:
	$(BUF) format -w

#########################
# Generate
#########################
.PHONY: generate
generate:
	$(BUF) generate

#########################
# Check
#########################
.PHONY: check
check: lint
	$(BUF) format --diff --exit-code
	$(BUF) generate
	go build ./...
	go vet ./...
