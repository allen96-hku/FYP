#!/bin/bash

# not using couchdb
export CHANNEL_NAME=athhall
COMPOSE_PROJECT_NAME=hkunetwork TIMEOUT=20000 docker-compose -f docker-compose-cli.yaml up -d

# using couch db
export CHANNEL_NAME=athhall
COMPOSE_PROJECT_NAME=hkunetwork TIMEOUT=20000 docker-compose -f docker-compose-cli.yaml -f docker-compose-couch.yaml up -d

docker exec -it cli bash