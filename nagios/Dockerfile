FROM polster/docker-nagios:latest

MAINTAINER Simon Dietschi

######################
# Build time arguments
######################

ARG NAGIOS_DOCKER_PLUGIN_VERSION=${nagios_docker_plugin_version:-1.0.0}

#######################
# Environment variables
#######################

ENV NAGIOS_HOME=/usr/local/nagios
ENV NAGIOS_USER=nagios
ENV NAGIOS_GROUP=nagios

###############
# Prerequisites
###############

RUN easy_install pip

###########
# Additions
###########

# Install Nagios Docker Plugin
ADD https://github.com/polster/nagios-docker-plugin/archive/v$NAGIOS_DOCKER_PLUGIN_VERSION.tar.gz /tmp/nagios-docker-plugin-$NAGIOS_DOCKER_PLUGIN_VERSION.tar.gz
RUN cd /tmp/ && tar xf nagios-docker-plugin-$NAGIOS_DOCKER_PLUGIN_VERSION.tar.gz
RUN cd /tmp/nagios-docker-plugin-$NAGIOS_DOCKER_PLUGIN_VERSION && cp check_docker.py $NAGIOS_HOME/libexec/check_docker.py
RUN cd /tmp/nagios-docker-plugin-$NAGIOS_DOCKER_PLUGIN_VERSION && pip install -r requirements.txt
RUN chmod u+x $NAGIOS_HOME/libexec/check_docker.py
RUN chown $NAGIOS_USER:$NAGIOS_GROUP $NAGIOS_HOME/libexec/check_docker.py

##################
# Container Config
##################

# start up
CMD ["/usr/bin/supervisord"]
