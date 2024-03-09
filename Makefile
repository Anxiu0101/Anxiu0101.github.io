.PHONY: install
install:
	poetry install

.PHONY: run
run:
	poetry run mkdocs serve

.PHONY: build
build:
	poetry run mkdocs build

.PHONY: update
update:
	poetry run mkdocs gh-deploy

# Service: MkDocs Static Website Generator.