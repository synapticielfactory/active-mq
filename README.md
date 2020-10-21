Docker Active-MQ
===============

[![Docker Pulls](https://img.shields.io/docker/pulls/rmohr/activemq.svg?maxAge=2592000)](https://hub.docker.com/r/synapticiel/activemq/)

[Docker](https://www.docker.io/) file for trusted builds of [ActiveMQ](http://activemq.apache.org/) on https://registry.hub.docker.com/u/rmohr/activemq/.

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

    docker run -p 61616:61616 -p 8161:8161 \
               -v /your/persistent/dir/conf:/opt/activemq/conf \
               -v /your/persistent/dir/data:/opt/activemq/data \
               synapticiel/activemq:5.16.0

ActiveMQ expects that some configuration files already exists, so they won't be
created automatically, instead you have to create them on your own before
starting the container. If you want to start with the default configuration you
can initialize your directories using some intermediate container:

    docker run --user root --rm -ti \
      -v /your/persistent/dir/conf:/mnt/conf \
      -v /your/persistent/dir/data:/mnt/data \
      synapticiel/activemq:5.16.0 /bin/sh

This will bring up a shell, so you can just execute the following commands
inside this intermediate container to copy the default configuration to your
host directory:

    chown activemq:activemq /mnt/conf
    chown activemq:activemq /mnt/data
    cp -a /opt/activemq/conf/* /mnt/conf/
    cp -a /opt/activemq/data/* /mnt/data/
    exit

The last command will stop and remove the intermediate container. Your
directories are now initialized and you can run ActiveMQ as described above.
