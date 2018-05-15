# Kubernetes Dynomite
Dynomite, inspired by Dynamo whitepaper, is a thin, distributed dynamo layer for 
different storage engines and protocols. Currently these include Redis and Memcached. 
Dynomite supports multi-datacenter replication and is designed for high availability.

The ultimate goal with Dynomite is to be able to implement high availability and 
cross-datacenter replication on storage engines that do not inherently provide 
that functionality. The implementation is efficient, not complex (few moving parts), 
and highly performant.

## Configuration

Dynomite can be configured through a YAML file specified by the -c or --conf-file 
command-line argument on process start. The configuration files parses and understands the following keys:

* env: Specify environment of a node. Currently supports aws and network (for physical datacenter).
* datacenter: The name of the datacenter. Please refer to architecture document.
* rack: The name of the rack. Please refer to architecture document.
* dyn_listen: The port that dynomite nodes use to inter-communicate and gossip.
* enable_gossip: enable gossip instead of static tokens (default: false). Gossip is experimental.
* gos_interval: The sleeping time in milliseconds at the end of a gossip round.
* tokens: The token(s) owned by a node. Currently, we don't support vnode yet so this only works with one token for the time being.
* dyn_seed_provider: A seed provider implementation to provide a list of seed nodes.
* dyn_seeds: A list of seed nodes in the format: address:port:rack:dc:tokens (node that vnode is not supported yet)
* listen: The listening address and port (name:port or ip:port) for this server pool.
* timeout: The timeout value in msec that we wait for to establish a connection to the server or receive a response from a server. By default, we wait indefinitely.
* preconnect: A boolean value that controls if dynomite should preconnect to all the servers in this pool on process start. Defaults to false.
* data_store: An integer value that controls if a server pool speaks redis (0) or memcached (1) or other protocol. Defaults to redis (0).
* auto_eject_hosts: A boolean value that controls if server should be ejected temporarily when it fails consecutively server_failure_limit times. See liveness recommendations for information. Defaults to false.
* server_retry_timeout: The timeout value in msec to wait for before retrying on a temporarily ejected server, when auto_eject_host is set to true. Defaults to 30000 msec.
* server_failure_limit: The number of consecutive failures on a server that would lead to it being temporarily ejected when auto_eject_host is set to true. Defaults to 2.
* servers: A list of local server address, port and weight (name:port:weight or ip:port:weight) for this server pool. Currently, there is just one.
* secure_server_option: Encrypted communication. Must be one of 'none', 'rack', 'datacenter', or 'all'. datacenter means all communication between datacenters is encrypted but within a datacenter it is not. rack means all communication between racks and regions is encrypted however communication between nodes within the same rack is not encrypted. all means all communication between all nodes is encrypted. And none means none of the communication is encrypted.
* stats_listen: The address and port number for the REST endpoint and for accessing statistics.
* stats_interval: set stats aggregation interval in msec (default: 30000 msec).
* mbuf_size: size of mbuf chunk in bytes (default: 16384 bytes).
* max_msgs: max number of messages to allocate (default: 200000).

Example config file:
```yaml
   dyn_o_mite:
     datacenter: us-east-1
     rack: us-east-1a
     dyn_listen: 0.0.0.0:8101
     dyn_seed_provider: florida_provider
     listen: 0.0.0.0:8102
     servers:
     - 127.0.0.1:22122:1
     tokens: 4294967295
     data_store: 0
     stats_listen: 0.0.0.0:22222
     auto_eject_hosts: true
     preconnect: true
```