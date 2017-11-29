#!/bin/bash

## kill stale or active containers
# docker rm -f $(docker ps -aq)

# clear cache network
# docker network prune

# remove fabcar chaincode
# docker rmi dev-peer0.org1.example.com-fabcar-1.0-5c906e402ed29f20260ae42283216aa75549c571e2e380f3615826365d8269ba


# CHANNEL_NAME=$CHANNEL_NAME
# COMPOSE_PROJECT_NAME=hkunetwork
TIMEOUT=20000 docker-compose -f docker-compose-cli.yaml up -d

docker exec -it cli bash