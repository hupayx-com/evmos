
KEY="mykey"
CHAINID="evmos_2022-1"
MONIKER="localtestnet"
KEYRING="test"
KEYALGO="eth_secp256k1"
LOGLEVEL="info"
# to trace evm
#TRACE="--trace"
TRACE=""

# validate dependencies are installed
command -v jq > /dev/null 2>&1 || { echo >&2 "jq not installed. More info: https://stedolan.github.io/jq/download/"; exit 1; }

# remove existing daemon
rm -rf ~/.hupayx*

# make install

evmosd config keyring-backend $KEYRING
evmosd config chain-id $CHAINID

# if $KEY exists it should be deleted
#evmosd keys add $KEY --keyring-backend $KEYRING --algo $KEYALGO
# localKey address 0x7cb61d4117ae31a12e393a1cfa3bac666481d02e  

USER_KEY=$KEY
USER_MNEMONIC="gesture inject test cycle original hollow east ridge hen combine junk child bacon zero hope comfort vacuum milk pitch cage oppose unhappy lunar seat"

echo $USER_MNEMONIC | evmosd keys add $USER_KEY --recover --keyring-backend test --algo "eth_secp256k1"


# Set moniker and chain-id for Evmos (Moniker can be anything, chain-id must be an integer)
evmosd init $MONIKER --chain-id $CHAINID 

# Change parameter token denominations to aphoton
cat $HOME/.hupayx/config/genesis.json | jq '.app_state["staking"]["params"]["bond_denom"]="ahpx"' > $HOME/.hupayx/config/tmp_genesis.json && mv $HOME/.hupayx/config/tmp_genesis.json $HOME/.hupayx/config/genesis.json
cat $HOME/.hupayx/config/genesis.json | jq '.app_state["crisis"]["constant_fee"]["denom"]="ahpx"' > $HOME/.hupayx/config/tmp_genesis.json && mv $HOME/.hupayx/config/tmp_genesis.json $HOME/.hupayx/config/genesis.json
cat $HOME/.hupayx/config/genesis.json | jq '.app_state["gov"]["deposit_params"]["min_deposit"][0]["denom"]="ahpx"' > $HOME/.hupayx/config/tmp_genesis.json && mv $HOME/.hupayx/config/tmp_genesis.json $HOME/.hupayx/config/genesis.json
cat $HOME/.hupayx/config/genesis.json | jq '.app_state["mint"]["params"]["mint_denom"]="ahpx"' > $HOME/.hupayx/config/tmp_genesis.json && mv $HOME/.hupayx/config/tmp_genesis.json $HOME/.hupayx/config/genesis.json


cat $HOME/.hupayx/config/genesis.json | jq '.app_state["staking"]["params"]["bond_denom"]="ahpx"' > $HOME/.hupayx/config/tmp_genesis.json && mv $HOME/.hupayx/config/tmp_genesis.json $HOME/.hupayx/config/genesis.json
cat $HOME/.hupayx/config/genesis.json | jq '.app_state["evm"]["params"]["evm_denom"]="ahpx"' > $HOME/.hupayx/config/tmp_genesis.json && mv $HOME/.hupayx/config/tmp_genesis.json $HOME/.hupayx/config/genesis.json


# increase block time (?)
cat $HOME/.hupayx/config/genesis.json | jq '.consensus_params["block"]["time_iota_ms"]="30000"' > $HOME/.hupayx/config/tmp_genesis.json && mv $HOME/.hupayx/config/tmp_genesis.json $HOME/.hupayx/config/genesis.json

# Set gas limit in genesis
cat $HOME/.hupayx/config/genesis.json | jq '.consensus_params["block"]["max_gas"]="10000000"' > $HOME/.hupayx/config/tmp_genesis.json && mv $HOME/.hupayx/config/tmp_genesis.json $HOME/.hupayx/config/genesis.json

# disable produce empty block
if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' 's/create_empty_blocks = true/create_empty_blocks = false/g' $HOME/.hupayx/config/config.toml
  else
    sed -i 's/create_empty_blocks = true/create_empty_blocks = false/g' $HOME/.hupayx/config/config.toml
fi

#if [[ $1 == "pending" ]]; then
if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' 's/create_empty_blocks_interval = "0s"/create_empty_blocks_interval = "30s"/g' $HOME/.hupayx/config/config.toml
    sed -i '' 's/timeout_propose = "3s"/timeout_propose = "30s"/g' $HOME/.hupayx/config/config.toml
    sed -i '' 's/timeout_propose_delta = "500ms"/timeout_propose_delta = "5s"/g' $HOME/.hupayx/config/config.toml
    sed -i '' 's/timeout_prevote = "1s"/timeout_prevote = "10s"/g' $HOME/.hupayx/config/config.toml
    sed -i '' 's/timeout_prevote_delta = "500ms"/timeout_prevote_delta = "5s"/g' $HOME/.hupayx/config/config.toml
    sed -i '' 's/timeout_precommit = "1s"/timeout_precommit = "10s"/g' $HOME/.hupayx/config/config.toml
    sed -i '' 's/timeout_precommit_delta = "500ms"/timeout_precommit_delta = "5s"/g' $HOME/.hupayx/config/config.toml
    sed -i '' 's/timeout_commit = "5s"/timeout_commit = "150s"/g' $HOME/.hupayx/config/config.toml
    sed -i '' 's/timeout_broadcast_tx_commit = "10s"/timeout_broadcast_tx_commit = "150s"/g' $HOME/.hupayx/config/config.toml

    sed -i 's/127.0.0.1:26657/0.0.0.0:26657/g' $HOME/.hupayx/config/config.toml
    sed -i '108s/enable = false/enable = true/' $HOME/.hupayx/config/app.toml
    sed -i '111s/swagger = false/swagger = true/' $HOME/.hupayx/config/app.toml
    

else
    sed -i 's/create_empty_blocks_interval = "0s"/create_empty_blocks_interval = "30s"/g' $HOME/.hupayx/config/config.toml
    sed -i 's/timeout_propose = "3s"/timeout_propose = "30s"/g' $HOME/.hupayx/config/config.toml
    sed -i 's/timeout_propose_delta = "500ms"/timeout_propose_delta = "5s"/g' $HOME/.hupayx/config/config.toml
    sed -i 's/timeout_prevote = "1s"/timeout_prevote = "10s"/g' $HOME/.hupayx/config/config.toml
    sed -i 's/timeout_prevote_delta = "500ms"/timeout_prevote_delta = "5s"/g' $HOME/.hupayx/config/config.toml
    sed -i 's/timeout_precommit = "1s"/timeout_precommit = "10s"/g' $HOME/.hupayx/config/config.toml
    sed -i 's/timeout_precommit_delta = "500ms"/timeout_precommit_delta = "5s"/g' $HOME/.hupayx/config/config.toml
    sed -i 's/timeout_commit = "5s"/timeout_commit = "150s"/g' $HOME/.hupayx/config/config.toml
    sed -i 's/timeout_broadcast_tx_commit = "10s"/timeout_broadcast_tx_commit = "150s"/g' $HOME/.hupayx/config/config.toml

    sed -i 's/127.0.0.1:26657/0.0.0.0:26657/g' $HOME/.hupayx/config/config.toml
    sed -i '108s/enable = false/enable = true/' $HOME/.hupayx/config/app.toml
    sed -i '111s/swagger = false/swagger = true/' $HOME/.hupayx/config/app.toml

fi
#fi

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
nohup evmosd start --pruning=nothing $TRACE --log_level $LOGLEVEL --minimum-gas-prices=0.0001ahpx --json-rpc.api eth,txpool,personal,net,debug,web3 &

