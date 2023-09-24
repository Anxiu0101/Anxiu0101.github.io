.PHONY: run
run:
	mkdocs serve

.PHONY: build
run_client:
	mkdocs build

.PHONY: update
update:
	mkdocs gh-deploy

# Service: MkDocs Static Website Generator.