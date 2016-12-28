SHELL=/bin/bash

# the default provider
PROVIDER=virtualbox
VM_LIST=docker-node01-dev nagios-client01-dev

up:
	time vagrant up --provider $(PROVIDER)

provision:
	time vagrant provision

destroy:
	time vagrant destroy ${VM_LIST}

status:
	@echo "---------------------------"
	vagrant status
	@echo "---------------------------"
	@echo "Docker host: [${DOCKER_HOST}]"
	docker ps

dependencies: dependencies-ansible-galaxy dependencies-ansible-docker dependencies-direnv

dependencies-ansible-docker:
	@echo "Preparing project specific env using direnv"
	direnv allow .
	@echo "Installing required Python packages"
	pip install 'docker-py>=1.7.0'
	pip install 'PyYAML>=3.11'
	pip install 'docker-compose>=1.7.0'

dependencies-ansible-galaxy:
	@echo "Installing Ansible dependency roles (re-install if already present)"
	rm -rf roles/*
	ansible-galaxy install -f -r requirements.yml -p roles

# Declare commands to be not associated with files
.PHONY: up provision destroy dependencies dependencies-ansible-docker dependencies-ansible-galaxy
