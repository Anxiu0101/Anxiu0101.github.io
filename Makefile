.PHONY: run
run:
	mkdocs serve

.PHONY: build
run_client:
	mkdocs build

.PHONY: update
run_server:
	mkdocs gh-deploy

# Service: MkDocs Static Website Generator.