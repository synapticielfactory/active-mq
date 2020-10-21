Docker Active-MQ
===============

[![Docker Pulls](https://img.shields.io/docker/pulls/rmohr/activemq.svg?maxAge=2592000)](https://hub.docker.com/r/synapticiel/activemq/)

[Docker](https://www.docker.io/) file for trusted builds of [ActiveMQ](http://activemq.apache.org/) on https://registry.hub.docker.com/u/synapticiel/activemq/.

Run the latest container with:

    docker pull synapticiel/activemq:5.16.0
    docker run -p 61616:61616 -p 8161:8161 synapticiel/activemq:5.16.0
	
	
# ActiveMQ Docker Image
Docker image with ActiveMQ  on CentOS Linux.

# Volumes

* /opt/apache-activemq/conf - Directory holding ActiveMQ configuration files.
* /opt/apache-activemq/data - Data directory. Will contain KahaDB data. Will not contain logs.
* /opt/apache-activemq/logs - Logs directory. In the default configuration, this directory will contain the ActiveMQ and audit log files.

# Ports

* 8161    - Web admin application and Jetty port (Chnage jetty.xml under config/ to bind IP if required).
* 61616   - TCP communication port (JMS/Openwire).
* 5672    - AMQP port.
* 61613   - Stomp port.
* 1883    - MQTT port.
* 61614   - WS port.# active-mq


Customizing configuration and persistence location
--------------------------------------------------
By default logs, data and configuration is stored inside the container and will be
lost after the container has been shut down and removed. To persist these
files you can mount these directories to directories on your host system:

docker run --network="host" \
  -v /opt/synapticiel/active-mq/data:/opt/apache-activemq/data \
  -v /opt/synapticiel/active-mq/conf:/opt/apache-activemq/conf \
  synapticiel/activemq:5.16.0
