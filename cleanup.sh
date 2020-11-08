#!/bin/bash

docker-compose down

docker volume rm docker-elk_data01 docker-elk_data02 docker-elk_data03 docker-elk_redis docker-elk_logstash
docker rmi docker-elk_redis
docker rmi docker-elk_logstash
docker rmi docker-elk_filebeat
docker rmi docker-elk_nginx

rm -f redis/redis.conf logstash/logs.conf filebeat/filebeat.yml
