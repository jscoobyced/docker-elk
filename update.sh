#!/bin/bash

ELKUSER=$1
ELKDOMAIN=$2
cd $(dirname $0)
mkdir -p ${PWD}/data/nginx/logs/

ssh ${ELKUSER}@${ELKDOMAIN} /bin/bash <<'ENDSSH'
cd /tmp
rm -Rf nginxlogs
mkdir nginxlogs
cd nginxlogs
cp /var/log/nginx/access_json.log* .
gunzip access_json.log*.gz
cat * > access_json_all.log
gzip access_json_all.log
rm *.log
ENDSSH

scp ${ELKUSER}@${ELKDOMAIN}:/tmp/nginxlogs/access_json_all.log.gz ${PWD}/data/nginx/logs/ > /dev/null
cd ${PWD}/data/nginx/logs/
gunzip access_json_all.log.gz
mv access_json_all.log access_json.log
