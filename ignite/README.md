# Kubernetes Ignite K8SES

[Apache Ignite][ignite] cluster can be easily deployed in and maintained by Kubernetes 
which is an open-source system for automating deployment, scaling, and management of containerized applications.
Apache Ignite is deployed as a [Deployment][deployment].

### Kubernetes IP Finder

Deployment of Apache Ignite nodes in the form of Kubernetes pods has certain requirements pertaining to Apache Ignite's nodes discovery mechanism. 
It is likely that you won't be able to use the straightforward multicast based IP finder because multicast traffic is usually blocked by firewalls. 
However, you can use the static IP finder and list the IP addresses of all the Ignite nodes as long as Kubernetes assigns the addresses dynamically.

To enable Apache Ignite nodes auto-discovery in Kubernetes, you need to enable TcpDiscoveryKubernetesIpFinder in IgniteConfiguration.

```xml
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:util="http://www.springframework.org/schema/util"
	xsi:schemaLocation="
		http://www.springframework.org/schema/beans
		http://www.springframework.org/schema/beans/spring-beans.xsd
		http://www.springframework.org/schema/util
		http://www.springframework.org/schema/util/spring-util.xsd">

<bean class="org.apache.ignite.configuration.IgniteConfiguration">
<property name="discoverySpi">
	<bean class="org.apache.ignite.spi.discovery.tcp.TcpDiscoverySpi">
	<property name="ipFinder">
		<bean class="org.apache.ignite.spi.discovery.tcp.ipfinder.kubernetes.TcpDiscoveryKubernetesIpFinder">
			<property name="setServiceName" value="ignite-svc"/>
			<property name="setNamespace" value="ignite"/>
		</bean>
	</property>
	</bean>
</property>
</bean>
</beans>
```

### Initialization


### Storage


[elasticsearch]: https://www.elastic.co/products/elasticsearch
[ignite]: https://ignite.apache.org/
[xPack]: https://www.elastic.co/products/x-pack
[setupCreds]: https://www.elastic.co/guide/en/x-pack/current/setting-up-authentication.html#reset-built-in-user-passwords
[configMap]: https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/
[secret]: https://kubernetes.io/docs/concepts/configuration/secret/
[deployment]: https://kubernetes.io/docs/concepts/workloads/controllers/deployment/
[initContainer]: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/
[pvc]: https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistentvolumeclaims
[storage]: https://kubernetes.io/docs/concepts/storage/storage-classes/

[![Analytics](https://kubernetes-site.appspot.com/UA-36037335-10/GitHub/cluster/addons/fluentd-elasticsearch/README.md?pixel)]()