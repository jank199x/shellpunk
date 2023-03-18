MAKEFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MAKEFILE_DIR := $(dir $(MAKEFILE_PATH))

.PHONY: build
build:
	docker build -t alpine-shellpunk .

.PHONY: run 
run:
	docker run --rm --name shellpunk --detach --publish 2342:22 --volume $(MAKEFILE_DIR)/shellpunk-home:/home/shellpunk alpine-shellpunk:latest

.PHONY: kill
kill:
	docker kill shellpunk   

.PHONY: connect
connect:
	ssh shellpunk@127.0.0.1 -p 2342
