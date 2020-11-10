#!/bin/bash


if [ $UID = 0 ] ;
then
  echo "You must not run as root. root privileges will be asked if needed."
fi

MAX_MAP_COUNT=$(sysctl -n vm.max_map_count)

if [ ${MAX_MAP_COUNT} -lt 262144 ];
then
  sudo sysctl -w vm.max_map_count=262144
fi

mkdir -p ${PWD}/data/es/data01 ${PWD}/data/es/data02 ${PWD}/data/es/data03 ${PWD}/data/filebeat/logs ${PWD}/data/nginx/logs ${PWD}/data/grafana/plugins

DOCKER_ELK="docker-elk_redis"
REDIS=$(docker images | grep ${DOCKER_ELK} | cut -d" " -f1)

if [ "${DOCKER_ELK}" != "${REDIS}" ];
then
  rm -f redis/redis.conf logstash/logs.conf
  REDIS_PWD=$(openssl rand -base64 36)
  sed -e 's@PASSPASSPASS@'"${REDIS_PWD}"'@g' redis/redis.conf.tpl > redis/redis.conf
  sed -e 's@PASSPASSPASS@'"${REDIS_PWD}"'@g' logstash/logstash.conf.tpl > logstash/logstash.conf
  sed -e 's@PASSPASSPASS@'"${REDIS_PWD}"'@g' filebeat/filebeat.yml.tpl > filebeat/filebeat.yml
fi

if [ "" != "$1" ];
then
  crontab -l > ${PWD}/crontab.bak
  cp ${PWD}/crontab.bak /tmp/crontab.elk
  echo "* * * * * ${PWD}/update.sh $1 $2" >> /tmp/crontab.elk
  crontab /tmp/crontab.elk
fi

GFUID=${UID} GFGID=${GID} docker-compose up -d