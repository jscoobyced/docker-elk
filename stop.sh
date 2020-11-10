#!/bin/bash

GFUID=${UID} GFGID=${GID} docker-compose down

crontab ${PWD}/crontab.bak
