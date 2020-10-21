#!/bin/bash
echo "Starting Active-MQ 5.16.0"
docker run --network="host" \
  -v /opt/synapticiel/active-mq/data:/opt/apache-activemq/data \
  -v /opt/synapticiel/active-mq/conf:/opt/apache-activemq/conf \
  synapticiel/activemq:5.16.0