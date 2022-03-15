all: clean build unit-test coverage package publish dockerize push integration_test

clean:
	@echo clean step
	rm -rf .pytest_cache 
	cd python-application-example && rm -rf dist .pytest_cache 
	cd python-application-example/src/tests && rm -rf __pycache__ .pytest_cache 
	cd python-application-example/src/ && rm -rf keepcoodingtest_pedro.egg-info
	docker rmi molinakiller/python-app:1.0.0 --force 2> /dev/null
build:
	@echo build step
	cd python-application-example && pip3 install -r requirements.txt

unit-test: 
	@echo unit test
	cd python-application-example/src/tests && coverage run -m pytest

coverage:
	@echo coverage
	cd python-application-example/src/tests && coverage report -m --fail-under=95

package:
	@echo package
	cd python-application-example && python3 -m build

publish:
	@echo publish
	cd python-application-example && python3 -m twine upload dist/* --config-file /home/pedro/Escritorio/personal/keepcoding/5-CICD/.pypirc --skip-existing

dockerize:
	@echo docker build
	cd docker && docker build -f Dockerfile -t molinakiller/python-app:2.0.0 .

push:
	@echo push to dockerhub
	docker push molinakiller/python-app:2.0.0

integration_test:
	@echo integration_test
	docker run molinakiller/python-app:2.0.0