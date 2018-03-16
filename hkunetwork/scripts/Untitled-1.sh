peer chaincode install -n hkucc -v 1.1 -p github.com/chaincode/hkuchaincode/go

export CHANNEL_NAME=cuhkchannel CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/clubA.cuhk.com/users/Admin@clubA.cuhk.com/msp CORE_PEER_ADDRESS=peer0.clubA.cuhk.com:7051 CORE_PEER_LOCALMSPID="ClubAMSP" CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/clubA.cuhk.com/peers/peer0.clubA.cuhk.com/tls/ca.crt

export CHANNEL_NAME=cuhkchannel CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/clubB.cuhk.com/users/Admin@clubB.cuhk.com/msp CORE_PEER_ADDRESS=peer0.clubB.cuhk.com:7051 CORE_PEER_LOCALMSPID="ClubBMSP" CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/clubB.cuhk.com/peers/peer0.clubB.cuhk.com/tls/ca.crt

export CHANNEL_NAME=athhall CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/athclub.hku.com/users/Admin@athclub.hku.com/msp CORE_PEER_ADDRESS=peer0.athclub.hku.com:7051 CORE_PEER_LOCALMSPID="AthClubMSP" CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/athclub.hku.com/peers/peer0.athclub.hku.com/tls/ca.crt

peer chaincode instantiate -o orderer.hku.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/hku.com/orderers/orderer.hku.com/msp/tlscacerts/tlsca.hku.com-cert.pem -C $CHANNEL_NAME -n hkucc -v 3.4 -c '{"Args":["init"]}' -P "OR ('ClubBMSP.member','ClubAMSP.member')"


peer chaincode instantiate -o orderer.hku.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/hku.com/orderers/orderer.hku.com/msp/tlscacerts/tlsca.hku.com-cert.pem -C $CHANNEL_NAME -n hkucc -v 1.8 -c '{"Args":["init"]}' -P "OR ('ClubBMSP.member','ClubAMSP.member')"


export CAFILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/hku.com/orderers/orderer.hku.com/msp/tlscacerts/tlsca.hku.com-cert.pem

peer chaincode install -n hkucc -v 3.8 -p github.com/chaincode/hkuchaincode/go

peer chaincode upgrade -o orderer.hku.com:7050 --tls --cafile $CAFILE -n hkucc -v 3.8 -C $CHANNEL_NAME -c '{"Args":["init"]}'

peer chaincode invoke -o orderer.hku.com:7050 --tls --cafile $CAFILE -C $CHANNEL_NAME -n hkucc -c '{"Args":["initUser", "wrong"]}'

peer chaincode invoke -o orderer.hku.com:7050 --tls --cafile $CAFILE -C $CHANNEL_NAME -n hkucc -c '{"Args":["initAC", "wrong"]}'

peer chaincode invoke -o orderer.hku.com:7050 --tls --cafile $CAFILE -C $CHANNEL_NAME -n hkucc -c '{"Args":["readState", "allenngan"]}'
peer chaincode invoke -o orderer.hku.com:7050 --tls --cafile $CAFILE -C $CHANNEL_NAME -n hkucc -c '{"Args":["readState", "e989eab5aa9d6cab"]}'

peer chaincode invoke -o orderer.hku.com:7050 --tls --cafile $CAFILE -C $CHANNEL_NAME -n hkucc -c '{"Args":["delAC", "e989eab5aa9d6cab"]}'

peer chaincode invoke -o orderer.hku.com:7050 --tls --cafile $CAFILE -C $CHANNEL_NAME -n hkucc -c '{"Args":["delUser", "allenngan"]}'

peer chaincode invoke -o orderer.hku.com:7050 --tls --cafile $CAFILE -C $CHANNEL_NAME -n hkucc -c '{"Args":["pay", "e989eab5aa9d6cab", "e989eab515d925b0", "200", "0"]}'

peer chaincode invoke -o orderer.hku.com:7050 --tls --cafile $CAFILE -C $CHANNEL_NAME -n hkucc -c '{"Args":["getHistory", "e989eab4a178f889"]}'

peer chaincode invoke -o orderer.hku.com:7050 --tls --cafile $CAFILE -C $CHANNEL_NAME -n hkucc -c '{"Args":["addValue", "e989eab5aa9d6cab", "10000"]}'

CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/hallA.hku.com/users/Admin@hallA.hku.com/msp CORE_PEER_ADDRESS=peer0.hallA.hku.com:7051 CORE_PEER_LOCALMSPID="HallAMSP" CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/hallA.hku.com/peers/peer0.hallA.hku.com/tls/ca.crt     peer chaincode invoke -o orderer.hku.com:7050 --tls --cafile $CAFILE -C $CHANNEL_NAME -n hkucc -c '{"Args":["initAC"]}'

CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/hallC.hku.com/users/Admin@hallC.hku.com/msp CORE_PEER_ADDRESS=peer0.hallC.hku.com:7051 CORE_PEER_LOCALMSPID="HallCMSP" CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/hallC.hku.com/peers/peer0.hallC.hku.com/tls/ca.crt      peer chaincode invoke -o orderer.hku.com:7050 --tls --cafile $CAFILE -C $CHANNEL_NAME -n hkucc -c '{"Args":["pay", "e989eab5af412683", "e989eab70a290869", "100", "0"]}'