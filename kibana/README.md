# Kubernetes Kibana K8SES


[Kibana][kibana] is deployed as a [Deployment][deployment] with Persistent Volume

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

First time Kibana will run and perform optimization which may take up to 20 minutes.
We use Persistent Volume to store optimization result so next time Kibana will start very quickly

### Storage

The Kibana Deployment will use the [Persistent Volume Claim][pvc] to
store data. **Important:** please specify name of your [Storage Class][storage] in your setup!

[elasticsearch]: https://www.elastic.co/products/elasticsearch
[kibana]: https://www.elastic.co/products/kibana
[xPack]: https://www.elastic.co/products/x-pack
[setupCreds]: https://www.elastic.co/guide/en/x-pack/current/setting-up-authentication.html#reset-built-in-user-passwords
[configMap]: https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/
[secret]: https://kubernetes.io/docs/concepts/configuration/secret/
[deployment]: https://kubernetes.io/docs/concepts/workloads/controllers/deployment/
[initContainer]: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/
[pvc]: https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistentvolumeclaims
[storage]: https://kubernetes.io/docs/concepts/storage/storage-classes/

[![Analytics](https://kubernetes-site.appspot.com/UA-36037335-10/GitHub/cluster/addons/fluentd-elasticsearch/README.md?pixel)]()