# ActiveMQ image running on CentOS Linux and OpenJDK 8.
#
# Build image with: docker build - < Dockerfile -t synapticiel/activemq:5.16.0 --network="host"
# Run image with: docker run --network="host" synapticiel/activemq:5.16.0
# Inspect image with: docker inspect synapticiel/activemq:5.16.0
# Remove <none> images : docker images | grep none | awk '{ print $3; }' | xargs docker rmi --force

FROM centos:latest
MAINTAINER Synapticiel LLC <contact@synapticiel.co>
LABEL version="5.16.0" description="Creates an ActiveMQ 5.16.0 server on CentOS Latest"

# Software version number.
ENV VERSION_NUMBER=5.16.0
# Archive name prefix, unpacked archive directory prefix and final directory name.
ENV FINAL_DIRECTORY_NAME=apache-activemq
# Software home directory.
ENV HOME_DIRECTORY=/opt/${FINAL_DIRECTORY_NAME}
# Product download URL.
ENV DOWNLOAD_URL=http://archive.apache.org/dist/activemq/${VERSION_NUMBER}/apache-activemq-${VERSION_NUMBER}-bin.tar.gz
# Name of user that product will be run by.
ENV RUN_AS_USER=activemq
# Configuration directory.
ENV CONFIGURATION_DIRECTORY=${HOME_DIRECTORY}/conf
# Logs directory. Does not exist in the default ActiveMQ binary distribution.
ENV LOGS_DIRECTORY=${HOME_DIRECTORY}/logs
# Data directory. Will also contain the pid file.
ENV DATA_DIRECTORY=${HOME_DIRECTORY}/data
# Create the user and group that will be used to run the software.
RUN groupadd ${RUN_AS_USER} && useradd -g ${RUN_AS_USER} ${RUN_AS_USER}

# make sure system is up-to-date
RUN yum -y update && \
    yum clean all

# install java
RUN yum -y install java-1.8.0-openjdk
RUN yum -y install wget
ENV JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk

#Download
RUN echo "Downloading from ${DOWNLOAD_URL} ..."
RUN wget -q "${DOWNLOAD_URL}"
RUN echo "Download done."
RUN tar xvzf ${FINAL_DIRECTORY_NAME}-*.tar.gz
RUN rm -f ${FINAL_DIRECTORY_NAME}-*.tar.gz
RUN mv ${FINAL_DIRECTORY_NAME}-* ${HOME_DIRECTORY}

# Create configuration, data and logs directories as needed.
RUN mkdir -p ${CONFIGURATION_DIRECTORY}
RUN mkdir -p ${DATA_DIRECTORY}
RUN mkdir -p ${LOGS_DIRECTORY}

# Set the owner of the configuration, data and logs directories in case they
# are not located in the home directory or any of its sub-directories.
RUN chown -R ${RUN_AS_USER}:${RUN_AS_USER} ${CONFIGURATION_DIRECTORY}
RUN chown -R ${RUN_AS_USER}:${RUN_AS_USER} ${DATA_DIRECTORY}
RUN chown -R ${RUN_AS_USER}:${RUN_AS_USER} ${LOGS_DIRECTORY}

# Set the owner of all files related to the software to the user which will be used to run it.
RUN chown -R ${RUN_AS_USER}:${RUN_AS_USER} ${HOME_DIRECTORY}

# Run Active-MQ
RUN echo "Work directory from ${HOME_DIRECTORY} ..."
RUN ls -all ${HOME_DIRECTORY}

WORKDIR ${HOME_DIRECTORY}
CMD ["/bin/sh", "-c", "bin/activemq console"]

# Expose ports for different types of interaction with ActiveMQ:
# Web admin application and HawtIO port.
EXPOSE 8161
# TCP communication port.
EXPOSE 61616
# AMQP port.
EXPOSE 5672
# Stomp port.
EXPOSE 61613
# MQTT port.
EXPOSE 1883
# WS port.
EXPOSE 61614

# Expose configuration, data and log directories.
VOLUME ["${CONFIGURATION_DIRECTORY}", "${DATA_DIRECTORY}", "${LOGS_DIRECTORY}"]