# Kubernetes Elasticsearch K8SES


Elasticsearch is deployed as a [StatefulSet][statefulSet], which is like
a Deployment, but allows for maintaining state on storage volumes. 

### Security

Elasticsearch has capabilities to enable authorization using the
[X-Pack plugin][xPack]. See configuration parameter `xpack.security.enabled`
in Elasticsearch and Kibana configurations. It can also be set via the
`XPACK_SECURITY_ENABLED` env variable. After enabling the feature,
follow [official documentation][setupCreds] to set up credentials in
Elasticsearch and Kibana. Don't forget to propagate those credentials also to
Fluentd in its [configuration][fluentdCreds], using for example
[environment variables][fluentdEnvVar]. You can utilize [ConfigMaps][configMap]
and [Secrets][secret] to store credentials in the Kubernetes apiserver.

### Initialization

The Elasticsearch StatefulSet manifest specifies that there shall be an
[init container][initContainer] executing before Elasticsearch containers
themselves, in order to ensure that the kernel state variable
`vm.max_map_count` is at least 262144, since this is a requirement of
Elasticsearch. You may remove the init container if you know that your host
OS meets this requirement.

### Storage

The Elasticsearch StatefulSet will use the hostPath volume to
store data. **Important:** please change the path to real path on your host in your setup!

[elasticsearch]: https://www.elastic.co/products/elasticsearch
[kibana]: https://www.elastic.co/products/kibana
[xPack]: https://www.elastic.co/products/x-pack
[setupCreds]: https://www.elastic.co/guide/en/x-pack/current/setting-up-authentication.html#reset-built-in-user-passwords
[configMap]: https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/
[secret]: https://kubernetes.io/docs/concepts/configuration/secret/
[statefulSet]: https://kubernetes.io/docs/concepts/workloads/controllers/statefulset
[initContainer]: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/
[daemonSet]: https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/

[![Analytics](https://kubernetes-site.appspot.com/UA-36037335-10/GitHub/cluster/addons/fluentd-elasticsearch/README.md?pixel)]()