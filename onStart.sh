#!/bin/bash

# Not ideal to hard code the zookeeper service name but will work for now.
# TODO: update script to take a parameter that contains the zookeeper service name.
# Don't think it can be automated, as only the person deploying schema-registry
# will know where the dependent zookeeper service is. 
echo "kafkastore.connection.url=zookeeper:2181" >> /etc/schema-registry/schema-registry.properties

# Start schema-registry container with our properties file.
exec /usr/bin/schema-registry-start /etc/schema-registry/schema-registry.properties
