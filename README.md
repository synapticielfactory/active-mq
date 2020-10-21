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
Active-MQ Docker image build based on CentOS Latest
