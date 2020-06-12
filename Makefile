## Build a docker image
build:
	DOCKER_BUILDKIT=1 docker build -t mysql_fdw_test:9.5-alpine .

.PHONY: build
