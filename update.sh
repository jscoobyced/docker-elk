#!/bin/bash

cd $(dirname $0)
mkdir -p ${PWD}/data/nginx/logs/
scp user@domain:/var/log/nginx/access_json.log ${PWD}/data/nginx/logs/ > /dev/null
