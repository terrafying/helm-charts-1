# Kubernetes Netflix Conductor 
Conductor is an orchestration engine that help to manage micro services

## Features
* Allow creating complex process / business flows in which individual task is implemented by a microservice.
* A JSON DSL based blueprint defines the execution flow.
* Provide visibility and traceability into the these process flows.
* Expose control semantics around pause, resume, restart, etc allowing for better devops experience.
* Allow greater reuse of existing microservices providing an easier path for onboarding.
* User interface to visualize the process flows.
* Ability to synchronously process all the tasks when needed.
* Ability to scale millions of concurrently running process flows.
* Backed by a queuing service abstracted from the clients.
* Be able to operate on HTTP or other transports e.g. gRPC.

## Configuration

### conductor-server.properties
```
# Database persistence model.  Possible values are memory, redis, redis_cluster and dynomite.
# If omitted, the persistence used is memory
#
# memory : The data is stored in memory and lost when the server dies.  Useful for testing or demo
# redis : non-Dynomite based redis instance
# redis_cluster: AWS Elasticache Redis (cluster mode enabled).See [http://docs.aws.amazon.com/AmazonElastiCache/latest/UserGuide/Clusters.Create.CON.RedisCluster.html]
# dynomite : Dynomite cluster.  Use this for HA configuration.
db=dynomite

# Dynomite Cluster details.
# format is host:port:rack separated by semicolon
# for AWS Elasticache Redis (cluster mode enabled) the format is configuration_endpoint:port:us-east-1e. The region in this case does not matter
workflow.dynomite.cluster.hosts=host1:8102:us-east-1c;host2:8102:us-east-1d;host3:8102:us-east-1e

# Dynomite cluster name
workflow.dynomite.cluster.name=dyno_cluster_name

# Maximum connections to redis/dynomite
workflow.dynomite.connection.maxConnsPerHost=31

# Namespace for the keys stored in Dynomite/Redis
workflow.namespace.prefix=conductor

# Namespace prefix for the dyno queues
workflow.namespace.queue.prefix=conductor_queues

# No. of threads allocated to dyno-queues (optional)
queues.dynomite.threads=10

# Non-quorum port used to connect to local redis.  Used by dyno-queues.
# When using redis directly, set this to the same port as redis server
# For Dynomite, this is 22122 by default or the local redis-server port used by Dynomite.
queues.dynomite.nonQuorum.port=22122

# Transport address to elasticsearch
workflow.elasticsearch.url=localhost:9300

# Name of the elasticsearch cluster
workflow.elasticsearch.index.name=conductor

# Additional modules (optional)
conductor.additional.modules=class_extending_com.google.inject.AbstractModule
```

### log4j.properties
```
log4j.rootLogger=INFO,stdout
log4j.appender.stdout=org.apache.log4j.ConsoleAppender
log4j.appender.stdout.layout=org.apache.log4j.PatternLayout
log4j.appender.stdout.layout.ConversionPattern=%p\t%d{ISO8601}\t%r\t%c\t[%t]\t%m%n
```