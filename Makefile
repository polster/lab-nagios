SHELL=/bin/bash

# the default provider
PROVIDER=virtualbox
DOCKER_NODE=docker-node01-dev
DOCKER_NAGIOS=nagios
DOCKER_NAGIOS_VOLUME=labnagios_nagios_data

docker-compose-up:
	docker-compose up -d --build

docker-deploy-nagios-config:
	@echo "----------------------"
	@echo "Copy Nagios config to ${DOCKER_NODE}"
	docker cp ./nagios-config/etc/objects/custom ${DOCKER_NAGIOS}:/usr/local/nagios/etc/objects/
	docker cp ./nagios-config/etc/objects/localhost.cfg ${DOCKER_NAGIOS}:/usr/local/nagios/etc/objects/
	docker cp ./nagios-config/etc/nagios.cfg ${DOCKER_NAGIOS}:/usr/local/nagios/etc/nagios.cfg
	@echo "----------------------"
	@echo "Verify Nagios config"
	docker exec ${DOCKER_NAGIOS} /usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg
	@echo "----------------------"
	@echo "Make the changes productive"
	docker restart ${DOCKER_NAGIOS}

docker-destroy:
	docker stop ${DOCKER_NAGIOS} && docker rm ${DOCKER_NAGIOS}
	docker volume rm ${DOCKER_NAGIOS_VOLUME}

docker-status:
	docker ps -a

vagrant-up:
	vagrant up --provider $(PROVIDER)

vagrant-provision:
	vagrant provision

vagrant-destroy:
	vagrant destroy

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

dependencies-vagrant:
	@echo "Installing Vagrant dependencies"
	vagrant plugin install vagrant-hostsupdater

# Declare commands to be not associated with files
.PHONY: status \
	vagrant-up vagrant-provision vagrant-destroy \
	dependencies dependencies-vagrant dependencies-ansible-galaxy dependencies-ansible-docker \
	dependencies-ansible-docker dependencies-ansible-galaxy \
	docker-compose-up docker-destroy docker-deploy-nagios-config
