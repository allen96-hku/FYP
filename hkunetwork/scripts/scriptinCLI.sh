#!/bin/bash

export CHANNEL_NAME=athhall

peer channel create -o orderer.hku.com:7050 -c $CHANNEL_NAME -f ./channel-artifacts/channel.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/hku.com/orderers/orderer.hku.com/msp/tlscacerts/tlsca.hku.com-cert.pem


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

#install chaincode
peer chaincode install -n fabcar -v 1.0 -p github.com/chaincode/fabcar

peer chaincode install -n sacc -v 1.0 -p github.com/chaincode/sacc

peer chaincode install -n mycc -v 1.0 -p github.com/chaincode/chaincode_example02/go

#instantiate chaincode
peer chaincode instantiate -o orderer.hku.com:7050 --tls $CORE_PEER_TLS_ENABLED --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/hku.com/orderers/orderer.hku.com/msp/tlscacerts/tlsca.hku.com-cert.pem -C $CHANNEL_NAME -n sacc -v 1.0 -c '{"Args":["Init", "a", "100"]}' -P "OR ('AthClubMSP.member','HallAMSP.member')"

peer chaincode instantiate -o orderer.hku.com:7050 --tls $CORE_PEER_TLS_ENABLED --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/hku.com/orderers/orderer.hku.com/msp/tlscacerts/tlsca.hku.com-cert.pem -C $CHANNEL_NAME -n fabcar -v 1.0 -c '{"Args":["init"]}' -P "OR ('AthClubMSP.member','HallAMSP.member')"

peer chaincode instantiate -o orderer.hku.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/hku.com/orderers/orderer.hku.com/msp/tlscacerts/tlsca.hku.com-cert.pem -C $CHANNEL_NAME -n mycc -v 1.0 -c '{"Args":["init","a", "100", "b","200"]}' -P "OR ('AthClubMSP.member','HallAMSP.member')"





#Query
# peer chaincode query -C $CHANNEL_NAME -n mycc -c '{"Args":["query","a"]}'

#Invoke & Query
# peer chaincode invoke -o orderer.hku.com:7050  --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/hku.com/orderers/orderer.hku.com/msp/tlscacerts/tlsca.hku.com-cert.pem  -C $CHANNEL_NAME -n mycc -c '{"Args":["invoke","a","b","10"]}'

# peer chaincode query -C $CHANNEL_NAME -n mycc -c '{"Args":["query","a"]}'
