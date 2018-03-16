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

##################################################################
################      NON-CouchDB Application      ###############
##################################################################

### Install chaincode
# fabcar
peer chaincode install -n fabcar -v 1.0 -p github.com/chaincode/fabcar
# sacc
peer chaincode install -n sacc -v 1.0 -p github.com/chaincode/sacc
# mycc
peer chaincode install -n mycc -v 1.0 -p github.com/chaincode/chaincode_example02/go


### Instantiate chaincode
# sacc
peer chaincode instantiate -o orderer.hku.com:7050 --tls $CORE_PEER_TLS_ENABLED --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/hku.com/orderers/orderer.hku.com/msp/tlscacerts/tlsca.hku.com-cert.pem -C $CHANNEL_NAME -n sacc -v 1.0 -c '{"Args":["a", "100"]}' -P "AND ('AthClubMSP.member','HallAMSP.member')"
# fabcar
peer chaincode instantiate -o orderer.hku.com:7050 --tls $CORE_PEER_TLS_ENABLED --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/hku.com/orderers/orderer.hku.com/msp/tlscacerts/tlsca.hku.com-cert.pem -C $CHANNEL_NAME -n fabcar -v 1.0 -c '{"Args":["init"]}' -P "OR ('AthClubMSP.member','HallAMSP.member')"
# mycc
peer chaincode instantiate -o orderer.hku.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/hku.com/orderers/orderer.hku.com/msp/tlscacerts/tlsca.hku.com-cert.pem -C $CHANNEL_NAME -n mycc -v 1.0 -c '{"Args":["init","a", "100", "b","200"]}' -P "OR ('AthClubMSP.member','HallAMSP.member')"


#Query
# mycc
peer chaincode query -C $CHANNEL_NAME -n mycc -c '{"Args":["query","a"]}'
# sacc
peer chaincode query -C $CHANNEL_NAME -n sacc -c '{"Args":["get","a"]}'

#Invoke & Query
# mycc
peer chaincode invoke -o orderer.hku.com:7050  --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/hku.com/orderers/orderer.hku.com/msp/tlscacerts/tlsca.hku.com-cert.pem  -C $CHANNEL_NAME -n mycc -c '{"Args":["invoke","a","b","10"]}'
peer chaincode query -C $CHANNEL_NAME -n mycc -c '{"Args":["query","a"]}'
# sacc
peer chaincode invoke -o orderer.hku.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/hku.com/orderers/orderer.hku.com/msp/tlscacerts/tlsca.hku.com-cert.pem -C $CHANNEL_NAME -n sacc -c '{"Args":["set","a","20"]}'
peer chaincode query -C $CHANNEL_NAME -n sacc -c '{"Args":["get","a"]}'



##################################################################
################       CouchDB Application        ################
##################################################################
### Check status with http://localhost:5984/_utils\

### Install & Instantiate chaincode (CouchDB)
peer chaincode install -n marbles02 -v 1.1 -p github.com/chaincode/marbles02/go


peer chaincode upgrade -o orderer.hku.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/hku.com/orderers/orderer.hku.com/msp/tlscacerts/tlsca.hku.com-cert.pem -n marbles02 -v 1.1 -C $CHANNEL_NAME -c '{"Args":["init"]}'


peer chaincode instantiate -o orderer.hku.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/hku.com/orderers/orderer.hku.com/msp/tlscacerts/tlsca.hku.com-cert.pem -C $CHANNEL_NAME -n marbles02 -v 1.0 -c '{"Args":["init"]}' -P "OR ('AthClubMSP.member','HallAMSP.member')"

### Create some marbles
peer chaincode invoke -o orderer.hku.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/hku.com/orderers/orderer.hku.com/msp/tlscacerts/tlsca.hku.com-cert.pem -C $CHANNEL_NAME -n marbles02 -c '{"Args":["initMarble","marble1","blue","35","tom"]}'
peer chaincode invoke -o orderer.hku.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/hku.com/orderers/orderer.hku.com/msp/tlscacerts/tlsca.hku.com-cert.pem -C $CHANNEL_NAME -n marbles02 -c '{"Args":["initMarble","marble2","red","50","tom"]}'
peer chaincode invoke -o orderer.hku.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/hku.com/orderers/orderer.hku.com/msp/tlscacerts/tlsca.hku.com-cert.pem -C $CHANNEL_NAME -n marbles02 -c '{"Args":["initMarble","marble3","blue","70","tom"]}'

### Transfer Marble 2 to jerry
peer chaincode invoke -o orderer.hku.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/hku.com/orderers/orderer.hku.com/msp/tlscacerts/tlsca.hku.com-cert.pem -C $CHANNEL_NAME -n marbles02 -c '{"Args":["transferMarble","marble2","jerry"]}'

### Transfer Blue Marble to jerry (Marble 2)
peer chaincode invoke -o orderer.hku.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/hku.com/orderers/orderer.hku.com/msp/tlscacerts/tlsca.hku.com-cert.pem -C $CHANNEL_NAME -n marbles02 -c '{"Args":["transferMarblesBasedOnColor","blue","jerry"]}'

### Delete Marble 1
peer chaincode invoke -o orderer.hku.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/hku.com/orderers/orderer.hku.com/msp/tlscacerts/tlsca.hku.com-cert.pem -C $CHANNEL_NAME -n marbles02 -c '{"Args":["delete","marble1"]}'

### Query on Marble 2
peer chaincode query -C $CHANNEL_NAME -n marbles02 -c '{"Args":["readMarble","marble2"]}'

### See History of Marble 1
peer chaincode query -C $CHANNEL_NAME -n marbles02 -c '{"Args":["getHistoryForMarble","marble1"]}'

### Query by owner
peer chaincode query -C $CHANNEL_NAME -n marbles02 -c '{"Args":["queryMarblesByOwner","jerry"]}'

peer chaincode query -C $CHANNEL_NAME -n marbles02 -c '{"Args":["queryMarbles","{\"selector\":{\"color\":\"red\"}}"]}'


peer chaincode query -C $CHANNEL_NAME -n marbles02 -c '{"Args":["getMarblesByRange","marble1", "marble3"]}'




peer chaincode install -n hkucc -v 1.0 -p github.com/chaincode/hkuchaincode/go

peer chaincode instantiate -o orderer.hku.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/hku.com/orderers/orderer.hku.com/msp/tlscacerts/tlsca.hku.com-cert.pem -C $CHANNEL_NAME -n hkucc -v 1.0 -c '{"Args":["init"]}' -P "AND ('AthClubMSP.member','HallAMSP.member')"


export CAFILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/hku.com/orderers/orderer.hku.com/msp/tlscacerts/tlsca.hku.com-cert.pem

peer chaincode install -n hkucc -v 1.7 -p github.com/chaincode/hkuchaincode/go

peer chaincode upgrade -o orderer.hku.com:7050 --tls --cafile $CAFILE -n hkucc -v 1.7 -C $CHANNEL_NAME -c '{"Args":["init"]}'

peer chaincode invoke -o orderer.hku.com:7050 --tls --cafile $CAFILE -C $CHANNEL_NAME -n hkucc -c '{"Args":["initUser"]}'

peer chaincode invoke -o orderer.hku.com:7050 --tls --cafile $CAFILE -C $CHANNEL_NAME -n hkucc -c '{"Args":["initAC"]}'

peer chaincode invoke -o orderer.hku.com:7050 --tls --cafile $CAFILE -C $CHANNEL_NAME -n hkucc -c '{"Args":["readState", "Admin@athclub.hku.com"]}'
peer chaincode invoke -o orderer.hku.com:7050 --tls --cafile $CAFILE -C $CHANNEL_NAME -n hkucc -c '{"Args":["readState", "e989eab5af412683"]}'

peer chaincode invoke -o orderer.hku.com:7050 --tls --cafile $CAFILE -C $CHANNEL_NAME -n hkucc -c '{"Args":["delAC", "e989eab4b6e70e78"]}'

peer chaincode invoke -o orderer.hku.com:7050 --tls --cafile $CAFILE -C $CHANNEL_NAME -n hkucc -c '{"Args":["delUser"]}'

peer chaincode invoke -o orderer.hku.com:7050 --tls --cafile $CAFILE -C $CHANNEL_NAME -n hkucc -c '{"Args":["pay", "e989eab4b6e70e78", "e989eab5af412683", "200", "0"]}'

peer chaincode invoke -o orderer.hku.com:7050 --tls --cafile $CAFILE -C $CHANNEL_NAME -n hkucc -c '{"Args":["addValue", "e989eab4b6e70e78", "1000"]}'

CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/hallA.hku.com/users/Admin@hallA.hku.com/msp CORE_PEER_ADDRESS=peer0.hallA.hku.com:7051 CORE_PEER_LOCALMSPID="HallAMSP" CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/hallA.hku.com/peers/peer0.hallA.hku.com/tls/ca.crt     peer chaincode invoke -o orderer.hku.com:7050 --tls --cafile $CAFILE -C $CHANNEL_NAME -n hkucc -c '{"Args":["initAC"]}'

CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/hallC.hku.com/users/Admin@hallC.hku.com/msp CORE_PEER_ADDRESS=peer0.hallC.hku.com:7051 CORE_PEER_LOCALMSPID="HallCMSP" CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/hallC.hku.com/peers/peer0.hallC.hku.com/tls/ca.crt      peer chaincode invoke -o orderer.hku.com:7050 --tls --cafile $CAFILE -C $CHANNEL_NAME -n hkucc -c '{"Args":["pay", "e989eab5af412683", "e989eab70a290869", "100", "0"]}'