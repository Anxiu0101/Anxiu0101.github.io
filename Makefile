.PHONY: run
run:
	poetry run mkdocs serve

.PHONY: build
run_client:
	poetry run mkdocs build

.PHONY: update
update:
	poetry run mkdocs gh-deploy

# Service: MkDocs Static Website Generator.