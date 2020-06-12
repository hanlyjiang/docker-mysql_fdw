## Build a docker image
build:
	DOCKER_BUILDKIT=1 docker build -t lukesilvia/mysql_fdw:9.5-alpine .

.PHONY: build
