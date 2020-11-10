#!/bin/bash

ELKUSER=$1
ELKDOMAIN=$2
cd $(dirname $0)
mkdir -p ${PWD}/data/nginx/logs/
scp ${ELKUSER}@${ELKDOMAIN}:/var/log/nginx/access_json.log ${PWD}/data/nginx/logs/file1 > /dev/null
scp ${ELKUSER}@${ELKDOMAIN}:/var/log/nginx/access_json.log.1 ${PWD}/data/nginx/logs/file0 > /dev/null

if [ -e ${PWD}/data/nginx/logs/file0 ];
then
  cat ${PWD}/data/nginx/logs/file0 ${PWD}/data/nginx/logs/file1 > ${PWD}/data/nginx/logs/access_json.log
else
  mv ${PWD}/data/nginx/logs/file1 ${PWD}/data/nginx/logs/access_json.log
fi