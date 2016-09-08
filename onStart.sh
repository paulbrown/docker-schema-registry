#!/bin/bash

# Not ideal to hard code the zookeeper service name but will work for now.
# TODO: update script to take a parameter that contains the zookeeper and
# schema-registry service names. 
# Don't think it can be automated, as zookeeper and schema-registry names
# could be different in each case.
echo "kafkastore.connection.url=zookeeper:2181" >> /etc/schema-registry/schema-registry.properties
echo "listeners=http://schema-registry:8081" >> /etc/schema-registry/schema-registry.properties


# Start schema-registry container with our properties file.
exec /usr/bin/schema-registry-start /etc/schema-registry/schema-registry.properties
