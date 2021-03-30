#!/bin/sh

# https://github.com/basho/riak-java-client/blob/develop/Makefile#L43-L59

PROJDIR=/Users/Projects/solutions/integration/messaging/RabbitMQ/dev/java-rabbitmq-showCase/certs
RESOURCES_DIR=$PROJDIR/resources/
CA_DIR=$PROJDIR/testca
CERTS_DIR=$CA_DIR/certificates
PRIVATE_DIR=$CA_DIR/private


cd /Users/devtools/integration/messaging/rabbit/rabbit-devOps/tls-gen/basic
make PASSWORD=test1234



#!/bin/sh

# https://stackoverflow.com/a/1710543

set -x
set -e

readonly password=test1234

readonly certs_root_dir="/Users/Projects/solutions/integration/messaging/RabbitMQ/dev/java-rabbitmq-showCase/certs"
readonly ca_cert="$certs_root_dir/testca/cacert.cer"
readonly client_cert="$certs_root_dir/client/cert.pem"
readonly client_key="$certs_root_dir/client/key.pem"
readonly client_pfx="$certs_root_dir/client/client.pfx"

rm -rf *.jks *.pkcs12

keytool -genkey -dname "cn=client-truststore" -alias client-truststore -keyalg RSA -keystore ./client-truststore.pkcs12 -storetype pkcs12 -keypass "$password" -storepass "$password"

# Adding keystore client-truststore.pkcs12
keytool -noprompt -import -keystore ./client-truststore.pkcs12 -storepass "$password" -trustcacerts -file "$ca_cert" -alias tls-gen_basic_ca

# To Generate a Key Pair and a Self-Signed Certificate
# If dname is provided, it's used as the subject of the generated certificate. Otherwise, the one from the certificate request is used.
#keytool -genkey -dname "cn=client-keystore" -alias client-keystore -keyalg RSA -keystore ./client-keystore.pkcs12 -storetype pkcs12 -keypass "$password" -storepass "$password"

keytool -genkey -dname "cn=guest" -alias guest-keystore -keyalg RSA -keystore ./client-keystore.pkcs12 -storetype pkcs12 -keypass "$password" -storepass "$password"

# create client.pfx output
openssl pkcs12 -export -out "$client_pfx" -passout "pass:$password" -inkey "$client_key" -in "$client_cert"

keytool -importkeystore -srckeystore "$client_pfx" -srcstoretype pkcs12 -srcstorepass "$password" -destkeystore ./client-keystore.pkcs12 -destkeypass "$password" -deststorepass "$password" -deststoretype pkcs12
