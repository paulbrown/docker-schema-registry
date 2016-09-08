# Schema-Registry on Kubernetes

Schema-Registry provides a serving layer for your metadata. It provides a RESTful interface for storing and retrieving Avro schemas. It stores a versioned history of all schemas, provides multiple compatibility settings and allows evolution of schemas according to the configured compatibility setting. It provides serializers that plug into Kafka clients that handle schema storage and retrieval for Kafka messages that are sent in the Avro format.

This schema-registry is based on the avro schema evolution concepts packaged by Confluent (http://docs.confluent.io/current/schema-registry/docs/intro.html). 

For schema registry to work, it requires access to a zookeeper cluster to determine leaders/followers, and a kafka cluster to store schema's in a kafka topic. Currently in the onStart script this is set to a kubernetes zookeeper service called 'zookeeper'. You can take a look at the zookeeper kubernetes setup here (https://github.com/paulbrown/docker-zookeeper).

### Deployment
This example has been deployed and tested using a local Minikube setup.

Minikube is a tool that makes it easy to run Kubernetes locally. Minikube runs a single-node Kubernetes cluster inside a VM on your laptop for users looking to try out Kubernetes or develop with it day-to-day.

Minikube packages and configures a Linux VM, Docker and all Kubernetes components, optimized for local development. Minikube supports Kubernetes features such as:
- DNS
- NodePorts
- ConfigMaps and Secrets
- Dashboards

Deploying onto a Kubernetes cluster is fairly easy. There are example kubernetes Service and Controller files in the [kube/](kube/) directory.

#### Deploy Services
A headless service must be create to expose the schema-registry.

```bash
$ kubectl create -f kube/schema-registry-service.yaml
```

#### Deploy Controller
This command will create a Controller which deploys the required number of replicas specified. For redundancy more than 1 schema-registry should be deployed, with the zookeeper service maintain leaders and followers. 

```
$ kubectl create -f kube/schema-registry-controller.yaml
```

### ToDo
- Make the population of the config value for the zookeeper service more dynamic and not hard coded in the onStart script. It could be as easy as passing in the service name as an environment variable as part of the schema-registry-controller kubernetes yaml file. This can then be set in the schema-registry properties file before start.
