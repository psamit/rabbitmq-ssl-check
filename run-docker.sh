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


docker build -f Dockerfile -t $tag .

docker rm -f $name

echo "Running new containers"

docker run -d -h myhostname --name $name -p 4071:15671 -p 4072:15672 -p 3112:5672 -p 3111:5671 $tag

docker logs -f --tail 100 $name
