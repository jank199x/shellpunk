MAKEFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MAKEFILE_DIR := $(dir $(MAKEFILE_PATH))

.PHONY: build
build: 
	docker build -t arch-shellpunk .

.PHONY: run 
run:
	docker run --rm --name shellpunk --detach --publish 2342:22 --volume $(MAKEFILE_DIR)/home:/home/shellpunk arch-shellpunk:latest

.PHONY: kill
kill:
	docker kill shellpunk   

.PHONY: restart
restart: kill run

.PHONY: rebuild
rebuild: kill build run

.PHONY: ssh-keygen
keygen: 
	ssh-keygen -f ssh/id_rsa

.PHONY: ssh-install-key
install-key: 
	ssh-copy-id -i ssh/id_rsa -p 2342 shellpunk@localhost

.PHONY: connect
connect:
	ssh -F $(MAKEFILE_DIR)/ssh/config -i $(MAKEFILE_DIR)/ssh/id_rsa shellpunk    

.PHONY: setup
setup: build run keygen install-key connect
