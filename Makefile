#Authored by Phillip Bailey
.PHONY: all up down
# .SILENT:
SHELL := '/bin/bash'

#This is required for custom Domain.
SONAR_HOSTNAME = sonar.127.0.0.1.xip.io

SONAR_IMAGE ?= sonarqube:8.5-community

SONAR_TOKEN = $(shell cat token.txt)
COMPOSE_PROJECT_NAME = docker-sonarqube
# Export variables
export SONAR_HOSTNAME
export SONAR_IMAGE
export SONARQUBE_URL
export SONAR_TOKEN
export COMPOSE_PROJECT_NAME

REQUIRED_BINS :=  mkcert jq docker
$(foreach bin,$(REQUIRED_BINS),\
    $(if $(shell command -v $(bin) 2> /dev/null),$(info Found required bin: `$(bin)`),$(error Please install `$(bin)`)))

all:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
	@echo
	make print_vars

print_vars:
	@echo
	@echo Print variables.
	@echo SonarImage: $$SONAR_IMAGE
	@echo

up: print_vars ## Build and run
	docker-compose up  -d

down:  ## Stop and delete everything
	docker-compose down -v --remove-orphans  --rmi all

stop:  ## Stop and don't delete
	docker-compose stop

start: print_vars ## Start everythin
	docker-compose start

create_certs: delete_certs
	cd certs && mkcert $$SONAR_HOSTNAME && mv $$SONAR_HOSTNAME.pem cert.crt \
	&&  mv $$SONAR_HOSTNAME-key.pem cert.key

delete_certs:
	cd certs && rm -f *.crt && rm -f *.key && rm -rf *.pem || true

create_token:
	 chmod +x ./config/token.sh && ./config/token.sh

delete_token:
	rm -f config/token.txt || true

# Needs more work
custom_up: print_vars create_certs
	docker-compose -f docker-compose-custom.yml up  -d

custom_down: print_vars
	docker-compose -f docker-compose-custom.yml down  -v --remove-orphans  --rmi all

clean: delete_certs delete_token
	docker-compose down -v  --rmi all  --remove-orphans 
	docker-compose -f code_analysis/python/docker-compose.yml down -v  --rmi all  --remove-orphans


code_python:
	docker-compose -f code_analysis/python/docker-compose.yml up || true



# build: delete_certs  create_certs
# 	 docker-compose up --build --no-start

# up: build ## Build and run the containers
# 	docker-compose up -d

# start: ## Start all containers
# 	docker-compose up

# stop: ## Stop all containers
# 	docker-compose down

# restart: ## Restart all containers
# 	docker-compose restart

# logs: ## Show container logs
# 	docker-compose logs

# clean: delete_certs ## Stop and Delete everything.
# 	docker-compose down -v  --rmi all  --remove-orphans

# rebuild:
# 	make clean && make build && make up

# shell: ## Get a shell into the container.
# 	 docker run -it cicd/jenkins:alpine /bin/bash
