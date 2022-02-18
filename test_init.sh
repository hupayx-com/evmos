rm -rf ~/.hupayx
CHAINID="evmos_2022-1"
MONIKER="node1"
KEYRING="test"
KEYALGO="eth_secp256k1"
LOGLEVEL="info"
TRACE=""

# user1 address 0xFb34dB389CD08a9F03FfFf61a8f737b16DEb9678
USER1_KEY="user2"
USER1_MNEMONIC="fly twist expect little future small clap boat clown avoid pill end capable jacket snow screen antenna connect dream narrow close outdoor dust field"

USER_KEY=$USER1_KEY
USER_MNEMONIC=$USER1_MNEMONIC

evmosd config keyring-backend $KEYRING
evmosd config chain-id $CHAINID

echo $USER1_MNEMONIC | evmosd keys add $USER1_KEY --recover --keyring-backend test --algo "eth_secp256k1"

evmosd init $MONIKER --chain-id $CHAINID

# Change parameter token denominations to aphoton
cat $HOME/.hupayx/config/genesis.json | jq '.app_state["staking"]["params"]["bond_denom"]="stake"' > $HOME/.hupayx/config/tmp_genesis.json && mv $HOME/.hupayx/config/tmp_genesis.json $HOME/.hupayx/config/genesis.json
cat $HOME/.hupayx/config/genesis.json | jq '.app_state["crisis"]["constant_fee"]["denom"]="ahpx"' > $HOME/.hupayx/config/tmp_genesis.json && mv $HOME/.hupayx/config/tmp_genesis.json $HOME/.hupayx/config/genesis.json
cat $HOME/.hupayx/config/genesis.json | jq '.app_state["gov"]["deposit_params"]["min_deposit"][0]["denom"]="ahpx"' > $HOME/.hupayx/config/tmp_genesis.json && mv $HOME/.hupayx/config/tmp_genesis.json $HOME/.hupayx/config/genesis.json
cat $HOME/.hupayx/config/genesis.json | jq '.app_state["mint"]["params"]["mint_denom"]="stake"' > $HOME/.hupayx/config/tmp_genesis.json && mv $HOME/.hupayx/config/tmp_genesis.json $HOME/.hupayx/config/genesis.json

# evm 수수료
cat $HOME/.hupayx/config/genesis.json | jq '.app_state["evm"]["params"]["evm_denom"]="ahpx"' > $HOME/.hupayx/config/tmp_genesis.json && mv $HOME/.hupayx/config/tmp_genesis.json $HOME/.hupayx/config/genesis.json

# increase block time (?)
cat $HOME/.hupayx/config/genesis.json | jq '.consensus_params["block"]["time_iota_ms"]="1000"' > $HOME/.hupayx/config/tmp_genesis.json && mv $HOME/.hupayx/config/tmp_genesis.json $HOME/.hupayx/config/genesis.json

# Set gas limit in genesis
cat $HOME/.hupayx/config/genesis.json | jq '.consensus_params["block"]["max_gas"]="10000000"' > $HOME/.hupayx/config/tmp_genesis.json && mv $HOME/.hupayx/config/tmp_genesis.json $HOME/.hupayx/config/genesis.json

cat $HOME/.hupayx/config/genesis.json | jq '.app_state["mint"]["minter"]["inflation"]="0.000000000000000000"' > $HOME/.hupayx/config/tmp_genesis.json && mv $HOME/.hupayx/config/tmp_genesis.json $HOME/.hupayx/config/genesis.json
cat $HOME/.hupayx/config/genesis.json | jq '.app_state["mint"]["params"]["inflation_min"]="0.000000000000000000"' > $HOME/.hupayx/config/tmp_genesis.json && mv $HOME/.hupayx/config/tmp_genesis.json $HOME/.hupayx/config/genesis.json

sed -i 's/create_empty_blocks = true/create_empty_blocks = false/g' $HOME/.hupayx/config/config.toml

sed -i 's/127.0.0.1:26657/0.0.0.0:26657/g' $HOME/.hupayx/config/config.toml
sed -i '108s/enable = false/enable = true/' $HOME/.hupayx/config/app.toml
sed -i '111s/swagger = false/swagger = true/' $HOME/.hupayx/config/app.toml



evmosd add-genesis-account $USER1_KEY 9900000000000000000000000000ahpx,100000000stake --keyring-backend $KEYRING

evmosd gentx $USER_KEY 100000000stake --keyring-backend test --chain-id $CHAINID

evmosd collect-gentxs

evmosd validate-genesis

evmosd start --pruning=nothing --log_level info --minimum-gas-prices=0.0001ahpx --json-rpc.api eth,txpool,personal,net,debug,web3
