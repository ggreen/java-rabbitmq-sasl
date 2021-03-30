


```shell script
rabbitmq-plugins enable rabbitmq_auth_mechanism_ssl
```


tls-gen uses hostname for the client certificate's CN, 
so this "username" had to be added to RabbitMQ, e.g. if hostname is shostakovich:

```shell script
rabbitmqctl add_user 'O=client,CN=gregoryg-a01.vmware.com' 'test1234'
rabbitmqctl set_permissions 'O=client,CN=gregoryg-a01.vmware.com' '.*' '.*' '.*'
```

readonly password='test1234'

readonly dir="$(realpath $PWD)"
readonly key_store="$dir/client-keystore.pkcs12"
readonly trust_store="$dir/client-truststore.pkcs12"


-Djavax.net.ssl.trustStore=/Users/Projects/solutions/integration/messaging/RabbitMQ/dev/java-rabbitmq-showCase/app/src/main/scripts/client-truststore.pkcs12 -Djavax.net.ssl.trustStoreType=PKCS12 -Djavax.net.ssl.trustStorePassword=$password -Djavax.net.ssl.keyStore=test1234 -Djavax.net.ssl.keyStoreType=PKCS12" -Djavax.net.ssl.keyStorePassword=test1234