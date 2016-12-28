Nagios Lab
==========

## Purpose

* DevOps playground for Nagios configuration management, testing, experimenting or may be don't try at home situations where a throw away environment is needed
* Sample project demonstrating how a Docker host can be set up and a [containerized Nagios Server](https://github.com/polster/docker-nagios) can be deployed with Ansible
* May also be used for education purposes

## Prerequisites

### Local Dev Env

The following dependencies need to be installed and configured accordingly:
* [direnv](https://direnv.net/)
* [virtualenv](https://virtualenv.pypa.io/en/stable/)
* [Vagrant](https://www.vagrantup.com/) with [VirtualBox](https://www.virtualbox.org/)
* [Vagrant Hostsupdater](https://github.com/cogitatio/vagrant-hostsupdater) (optional, if you want to have Vagrant box hostnames being added to the localhost file)
* [Ansible](https://www.ansible.com/) 2.1 or newer
