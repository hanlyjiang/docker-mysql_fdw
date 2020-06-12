## Build a docker image
build:
	DOCKER_BUILDKIT=1 docker build -t mysql_fdw:9.5-alpine .

.PHONY: build
