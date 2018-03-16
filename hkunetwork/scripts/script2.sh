###############################################
###################  Gen  #####################
###############################################

# Generate Cryptomaterial
../bin/cryptogen generate --config=./crypto-config.yaml
../bin/cryptogen generate --config=./crypto-config2.yaml

# HKU
export FABRIC_CFG_PATH=$PWD
mkdir channel-artifacts
../bin/configtxgen -profile SixOrgsOrdererGenesis -outputBlock ./channel-artifacts/genesis.block

export CHANNEL_NAME=athhall
../bin/configtxgen -profile FourOrgsChannel -outputCreateChannelTx ./channel-artifacts/athhall.tx -channelID $CHANNEL_NAME

# Anchor Peer Update TX
../bin/configtxgen -profile FourOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/AthClubMSPanchors.tx -channelID $CHANNEL_NAME -asOrg AthClubMSP
../bin/configtxgen -profile FourOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/HallAMSPanchors.tx -channelID $CHANNEL_NAME -asOrg HallAMSP
../bin/configtxgen -profile FourOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/HallBMSPanchors.tx -channelID $CHANNEL_NAME -asOrg HallBMSP
../bin/configtxgen -profile FourOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/HallCMSPanchors.tx -channelID $CHANNEL_NAME -asOrg HallCMSP

export CHANNEL_NAME=cuhkchannel
../bin/configtxgen -profile TwoOrgsChannel -outputCreateChannelTx ./channel-artifacts/cuhkchannel.tx -channelID $CHANNEL_NAME



###############################################
##########  starting the network  #############
###############################################

export CHANNEL_NAME=athhall
COMPOSE_PROJECT_NAME=hkunetwork TIMEOUT=20000 docker-compose -f docker-compose-cli.yaml -f docker-compose-couch.yaml -f docker-compose-couch2.yaml up -d

docker exec -it cli bash

###############################################
###################  CLI  #####################
###############################################

export CHANNEL_NAME=athhall

peer channel create -o orderer.hku.com:7050 -c $CHANNEL_NAME -f ./channel-artifacts/athhall.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/hku.com/orderers/orderer.hku.com/msp/tlscacerts/tlsca.hku.com-cert.pem


#AthClub Peer0
peer channel join -b athhall.block

#AthClub Peer1
CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/athclub.hku.com/users/Admin@athclub.hku.com/msp CORE_PEER_ADDRESS=peer1.athclub.hku.com:7051 CORE_PEER_LOCALMSPID="AthClubMSP" CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/athclub.hku.com/peers/peer1.athclub.hku.com/tls/ca.crt peer channel join -b athhall.block

#hallA Peer0
CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/hallA.hku.com/users/Admin@hallA.hku.com/msp CORE_PEER_ADDRESS=peer0.hallA.hku.com:7051 CORE_PEER_LOCALMSPID="HallAMSP" CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/hallA.hku.com/peers/peer0.hallA.hku.com/tls/ca.crt peer channel join -b athhall.block

#hallA Peer1
CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/hallA.hku.com/users/Admin@hallA.hku.com/msp CORE_PEER_ADDRESS=peer1.hallA.hku.com:7051 CORE_PEER_LOCALMSPID="HallAMSP" CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/hallA.hku.com/peers/peer1.hallA.hku.com/tls/ca.crt peer channel join -b athhall.block

#hallB Peer0
CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/hallB.hku.com/users/Admin@hallB.hku.com/msp CORE_PEER_ADDRESS=peer0.hallB.hku.com:7051 CORE_PEER_LOCALMSPID="HallBMSP" CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/hallB.hku.com/peers/peer0.hallB.hku.com/tls/ca.crt peer channel join -b athhall.block
#hallB Peer1
CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/hallB.hku.com/users/Admin@hallB.hku.com/msp CORE_PEER_ADDRESS=peer1.hallB.hku.com:7051 CORE_PEER_LOCALMSPID="HallBMSP" CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/hallB.hku.com/peers/peer1.hallB.hku.com/tls/ca.crt peer channel join -b athhall.block

#hallC Peer0
CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/hallC.hku.com/users/Admin@hallC.hku.com/msp CORE_PEER_ADDRESS=peer0.hallC.hku.com:7051 CORE_PEER_LOCALMSPID="HallCMSP" CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/hallC.hku.com/peers/peer0.hallC.hku.com/tls/ca.crt peer channel join -b athhall.block
#hallC Peer1
CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/hallC.hku.com/users/Admin@hallC.hku.com/msp CORE_PEER_ADDRESS=peer1.hallC.hku.com:7051 CORE_PEER_LOCALMSPID="HallCMSP" CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/hallC.hku.com/peers/peer1.hallC.hku.com/tls/ca.crt peer channel join -b athhall.block


#Define athclub Peer 0 as anchor peer
peer channel update -o orderer.hku.com:7050 -c $CHANNEL_NAME -f ./channel-artifacts/AthClubMSPanchors.tx --tls $CORE_PEER_TLS_ENABLED --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/hku.com/orderers/orderer.hku.com/msp/tlscacerts/tlsca.hku.com-cert.pem
#Define hallA Peer 0 as anchor peer
CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/hallA.hku.com/users/Admin@hallA.hku.com/msp CORE_PEER_ADDRESS=peer0.hallA.hku.com:7051 CORE_PEER_LOCALMSPID="HallAMSP" CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/hallA.hku.com/peers/peer0.hallA.hku.com/tls/ca.crt peer channel update -o orderer.hku.com:7050 -c $CHANNEL_NAME -f ./channel-artifacts/HallAMSPanchors.tx --tls $CORE_PEER_TLS_ENABLED --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/hku.com/orderers/orderer.hku.com/msp/tlscacerts/tlsca.hku.com-cert.pem
#Define hallB Peer 0 as anchor peer
CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/hallB.hku.com/users/Admin@hallB.hku.com/msp CORE_PEER_ADDRESS=peer0.hallB.hku.com:7051 CORE_PEER_LOCALMSPID="HallBMSP" CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/hallB.hku.com/peers/peer0.hallB.hku.com/tls/ca.crt peer channel update -o orderer.hku.com:7050 -c $CHANNEL_NAME -f ./channel-artifacts/HallBMSPanchors.tx --tls $CORE_PEER_TLS_ENABLED --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/hku.com/orderers/orderer.hku.com/msp/tlscacerts/tlsca.hku.com-cert.pem
#Define hallC Peer 0 as anchor peer
CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/hallC.hku.com/users/Admin@hallC.hku.com/msp CORE_PEER_ADDRESS=peer0.hallC.hku.com:7051 CORE_PEER_LOCALMSPID="HallCMSP" CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/hallC.hku.com/peers/peer0.hallC.hku.com/tls/ca.crt peer channel update -o orderer.hku.com:7050 -c $CHANNEL_NAME -f ./channel-artifacts/HallCMSPanchors.tx --tls $CORE_PEER_TLS_ENABLED --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/hku.com/orderers/orderer.hku.com/msp/tlscacerts/tlsca.hku.com-cert.pem

##################################################################
################        2nd Channel Set Up         ###############
##################################################################

export CHANNEL_NAME=cuhkchannel

CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/clubA.cuhk.com/users/Admin@clubA.cuhk.com/msp CORE_PEER_ADDRESS=peer0.clubA.cuhk.com:7051 CORE_PEER_LOCALMSPID="ClubAMSP" CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/clubA.cuhk.com/peers/peer0.clubA.cuhk.com/tls/ca.crt peer channel create -o orderer.hku.com:7050 -c cuhkchannel -f ./channel-artifacts/cuhkchannel.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/hku.com/orderers/orderer.hku.com/msp/tlscacerts/tlsca.hku.com-cert.pem


# ClubA Peer0
CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/clubA.cuhk.com/users/Admin@clubA.cuhk.com/msp CORE_PEER_ADDRESS=peer0.clubA.cuhk.com:7051 CORE_PEER_LOCALMSPID="ClubAMSP" CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/clubA.cuhk.com/peers/peer0.clubA.cuhk.com/tls/ca.crt peer channel join -b cuhkchannel.block

# ClubB Peer0
CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/clubB.cuhk.com/users/Admin@clubB.cuhk.com/msp CORE_PEER_ADDRESS=peer0.clubB.cuhk.com:7051 CORE_PEER_LOCALMSPID="ClubBMSP" CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/clubB.cuhk.com/peers/peer0.clubB.cuhk.com/tls/ca.crt peer channel join -b cuhkchannel.block



##################################################################
################       CouchDB Application        ################
##################################################################
### Check status with http://localhost:5984/_utils\

peer chaincode install -n hkucc -v 1.1 -p github.com/chaincode/hkuchaincode/go

export CHANNEL_NAME=cuhkchannel CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/clubA.cuhk.com/users/Admin@clubA.cuhk.com/msp CORE_PEER_ADDRESS=peer0.clubA.cuhk.com:7051 CORE_PEER_LOCALMSPID="ClubAMSP" CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/clubA.cuhk.com/peers/peer0.clubA.cuhk.com/tls/ca.crt

export CHANNEL_NAME=cuhkchannel CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/clubB.cuhk.com/users/Admin@clubB.cuhk.com/msp CORE_PEER_ADDRESS=peer0.clubB.cuhk.com:7051 CORE_PEER_LOCALMSPID="ClubBMSP" CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/clubB.cuhk.com/peers/peer0.clubB.cuhk.com/tls/ca.crt

export CHANNEL_NAME=athhall CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/athclub.hku.com/users/Admin@athclub.hku.com/msp CORE_PEER_ADDRESS=peer0.athclub.hku.com:7051 CORE_PEER_LOCALMSPID="AthClubMSP" CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/athclub.hku.com/peers/peer0.athclub.hku.com/tls/ca.crt

peer chaincode instantiate -o orderer.hku.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/hku.com/orderers/orderer.hku.com/msp/tlscacerts/tlsca.hku.com-cert.pem -C $CHANNEL_NAME -n hkucc -v 3.4 -c '{"Args":["init"]}' -P "OR ('ClubBMSP.member','ClubAMSP.member')"


peer chaincode instantiate -o orderer.hku.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/hku.com/orderers/orderer.hku.com/msp/tlscacerts/tlsca.hku.com-cert.pem -C $CHANNEL_NAME -n hkucc -v 1.8 -c '{"Args":["init"]}' -P "OR ('ClubBMSP.member','ClubAMSP.member')"


export CAFILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/hku.com/orderers/orderer.hku.com/msp/tlscacerts/tlsca.hku.com-cert.pem

peer chaincode install -n hkucc -v 3.7 -p github.com/chaincode/hkuchaincode/go

peer chaincode upgrade -o orderer.hku.com:7050 --tls --cafile $CAFILE -n hkucc -v 3.7 -C $CHANNEL_NAME -c '{"Args":["init"]}'

peer chaincode invoke -o orderer.hku.com:7050 --tls --cafile $CAFILE -C $CHANNEL_NAME -n hkucc -c '{"Args":["initUser"]}'

peer chaincode invoke -o orderer.hku.com:7050 --tls --cafile $CAFILE -C $CHANNEL_NAME -n hkucc -c '{"Args":["initAC"]}'

peer chaincode invoke -o orderer.hku.com:7050 --tls --cafile $CAFILE -C $CHANNEL_NAME -n hkucc -c '{"Args":["readState", "Admin@clubA.cuhk.com"]}'
peer chaincode invoke -o orderer.hku.com:7050 --tls --cafile $CAFILE -C $CHANNEL_NAME -n hkucc -c '{"Args":["readState", "e989eab5af412683"]}'

peer chaincode invoke -o orderer.hku.com:7050 --tls --cafile $CAFILE -C $CHANNEL_NAME -n hkucc -c '{"Args":["delAC", "e989eab5b6e70e78"]}'

peer chaincode invoke -o orderer.hku.com:7050 --tls --cafile $CAFILE -C $CHANNEL_NAME -n hkucc -c '{"Args":["delUser"]}'

peer chaincode invoke -o orderer.hku.com:7050 --tls --cafile $CAFILE -C $CHANNEL_NAME -n hkucc -c '{"Args":["pay", "e989eab4a178f889", "e989eab5a178f889", "200", "0"]}'

peer chaincode invoke -o orderer.hku.com:7050 --tls --cafile $CAFILE -C $CHANNEL_NAME -n hkucc -c '{"Args":["getHistory", "e989eab4a178f889"]}'

peer chaincode invoke -o orderer.hku.com:7050 --tls --cafile $CAFILE -C $CHANNEL_NAME -n hkucc -c '{"Args":["addValue", "e989eab4a178f889", "10000"]}'

CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/hallA.hku.com/users/Admin@hallA.hku.com/msp CORE_PEER_ADDRESS=peer0.hallA.hku.com:7051 CORE_PEER_LOCALMSPID="HallAMSP" CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/hallA.hku.com/peers/peer0.hallA.hku.com/tls/ca.crt     peer chaincode invoke -o orderer.hku.com:7050 --tls --cafile $CAFILE -C $CHANNEL_NAME -n hkucc -c '{"Args":["initAC"]}'

CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/hallC.hku.com/users/Admin@hallC.hku.com/msp CORE_PEER_ADDRESS=peer0.hallC.hku.com:7051 CORE_PEER_LOCALMSPID="HallCMSP" CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/hallC.hku.com/peers/peer0.hallC.hku.com/tls/ca.crt      peer chaincode invoke -o orderer.hku.com:7050 --tls --cafile $CAFILE -C $CHANNEL_NAME -n hkucc -c '{"Args":["pay", "e989eab5af412683", "e989eab70a290869", "100", "0"]}'