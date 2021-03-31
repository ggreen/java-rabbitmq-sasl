
#Background

https://github.com/basho/riak-client-tools.git


Extract CN

    openssl x509 -in /Users/devtools/integration/messaging/rabbit/rabbit-devOps/tls-gen/basic/result/client_certificate.pem  -nameopt RFC2253 -subject -noout


Create trust store

    keytool -import -alias server1 -file /Users/devtools/integration/messaging/rabbit/rabbit-devOps/tls-gen/basic/result/server_certificate.pem -keystore /Users/Projects/solutions/integration/messaging/RabbitMQ/dev/java-rabbitmq-sasl/certs/rabbitstore


```shell script
rabbitmq-plugins enable rabbitmq_auth_mechanism_ssl
```


tls-gen uses hostname for the client certificate's CN, 
so this "username" had to be added to RabbitMQ, e.g. if hostname is gregoryg-a01.vmware.com:

```shell script
rabbitmqctl add_user 'O=client,CN=gregoryg-a01.vmware.com' 'test1234'
rabbitmqctl set_permissions 'Os=client,CN=gregoryg-a01.vmware.com' '.*' '.*' '.*'
```





gradle run


export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_261.jdk/Contents/Home
/Users/Projects/solutions/integration/messaging/RabbitMQ/dev/java-rabbitmq-sasl$ export PATH=$JAVA_HOME/bin:$PATH
