#!/bin/bash

export CHANNEL_NAME=athhall
COMPOSE_PROJECT_NAME=hkunetwork TIMEOUT=20000 docker-compose -f docker-compose-cli.yaml up -d

docker exec -it cli bash