#!/bin/bash

# Generate Crptomaterial
../bin/cryptogen generate --config=./crypto-config.yaml

# Generate genesis.block, 
export FABRIC_CFG_PATH=$PWD
mkdir channel-artifacts
../bin/configtxgen -profile FourOrgsOrdererGenesis -outputBlock ./channel-artifacts/genesis.block

export CHANNEL_NAME=athhall
../bin/configtxgen -profile FourOrgsChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID $CHANNEL_NAME


../bin/configtxgen -profile FourOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/AthClubMSPanchors.tx -channelID $CHANNEL_NAME -asOrg AthClubMSP
../bin/configtxgen -profile FourOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/HallAMSPanchors.tx -channelID $CHANNEL_NAME -asOrg HallAMSP
../bin/configtxgen -profile FourOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/HallBMSPanchors.tx -channelID $CHANNEL_NAME -asOrg HallBMSP
../bin/configtxgen -profile FourOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/HallCMSPanchors.tx -channelID $CHANNEL_NAME -asOrg HallCMSP

