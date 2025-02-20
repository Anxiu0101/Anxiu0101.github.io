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

.PHONY: create
create:
	powershell -ExecutionPolicy Bypass -File ./create.ps1 $(fileName)
# make create fileName=example-file.md


# Service: MkDocs Static Website Generator.