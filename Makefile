all-setup: venv pre-commit-install install-pytest

all-upload-test: clean-dist test build pypi-upload-test clean-dist
pypi-upload-test:
	$(with_venv) && \
	python3 -m twine upload --repository testpypi dist/*


all-upload-prod: clean-dist test build pypi-upload-prod clean-dist
pypi-upload-prod:
	$(with_venv) && \
	python3 -m twine upload dist/*


with_venv := source venv/bin/activate
venv:
	python3 -m venv venv
pre-commit-install:
	pre-commit install
install-pytest: venv
	$(with_venv) && \
	pip install pytest
test:
	$(with_venv) && \
	python3 -m pytest
build:
	$(with_venv) && \
	pip install --upgrade build twine && \
	python -m build && \
	cd src && \
	ls | grep .egg-info | xargs rm -r
clean-dist:
	rm -rf dist
