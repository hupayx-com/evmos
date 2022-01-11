
KEY="mykey"
CHAINID="evmos_2022-1"
MONIKER="localtestnet"
KEYRING="test"
KEYALGO="eth_secp256k1"
LOGLEVEL="info"
# to trace evm
#TRACE="--trace"
TRACE=""
 
# Allocate genesis accounts (cosmos formatted addresses)
evmosd add-genesis-account $KEY 100000000000000000000000000ahpx --keyring-backend $KEYRING

# Sign genesis transaction
evmosd gentx $KEY 1000000000000000000000ahpx --keyring-backend $KEYRING --chain-id $CHAINID

# Collect genesis tx
evmosd collect-gentxs

# Run this to ensure everything worked and that the genesis file is setup correctly
evmosd validate-genesis

if [[ $1 == "pending" ]]; then
  echo "pending mode is on, please wait for the first block committed."
fi

# Start the node (remove the --pruning=nothing flag if historical queries are not needed)
evmosd start --pruning=nothing $TRACE --log_level $LOGLEVEL --minimum-gas-prices=0.0001ahpx --json-rpc.api eth,txpool,personal,net,debug,web3

