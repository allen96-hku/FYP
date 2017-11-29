#!/bin/bash

# Generate Cryptomaterial
../bin/cryptogen generate --config=./crypto-config.yaml

# Genesis block
export FABRIC_CFG_PATH=$PWD
mkdir channel-artifacts
../bin/configtxgen -profile FourOrgsOrdererGenesis -outputBlock ./channel-artifacts/genesis.block

# Channel TX
export CHANNEL_NAME=athhall
../bin/configtxgen -profile FourOrgsChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID $CHANNEL_NAME

# Anchor Peer Update TX
../bin/configtxgen -profile FourOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/AthClubMSPanchors.tx -channelID $CHANNEL_NAME -asOrg AthClubMSP
../bin/configtxgen -profile FourOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/HallAMSPanchors.tx -channelID $CHANNEL_NAME -asOrg HallAMSP
../bin/configtxgen -profile FourOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/HallBMSPanchors.tx -channelID $CHANNEL_NAME -asOrg HallBMSP
../bin/configtxgen -profile FourOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/HallCMSPanchors.tx -channelID $CHANNEL_NAME -asOrg HallCMSP

