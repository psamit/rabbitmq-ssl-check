#!/bin/bash

usage () {
    cat << EOU
Usage : bash $0 <tag>
EOU
exit 1
}
if [ "$#" -lt 1 ]
then
    usage
fi

name=tls-rabbitmq
version=$1
tag=$name:$version


docker build -f Dockerfile -t $tag . --no-cache

docker rm -f $name

echo "Running new containers"

docker run -d --name $name -p 4072:15672 -p 3112:5672 -p 3111:5671 $tag
# docker run -d --name $name -p 4072:15672 -p 3112:5672 -p 3111:5671 -e RABBITMQ_DEFAULT_USER=user -e RABBITMQ_DEFAULT_PASS=password -e RABBITMQ_SSL_CACERTFILE=/etc/rabbitmq/cert/ca_certificate.pem -e RABBITMQ_SSL_CERTFILE=/etc/rabbitmq/cert/server_certificate.pem -e RABBITMQ_SSL_KEYFILE=/etc/rabbitmq/cert/server_key.pem -e RABBITMQ_SSL_VERIFY=verify_peer $tag


docker logs -f --tail 100 $name
