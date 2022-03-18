
KEY="mykey"
CHAINID="evmos_9000-1"
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
rm -rf ~/.evmosd*

make install

USER_MNEMONIC="birth theory violin october learn bitter arch ozone game blush rabbit force mother enter clarify pride chunk dinner assault split dune basket clump eye"


test1="mail equip setup excess skate crew auction chunk method trouble weekend wonder gown correct regret boil slogan science leader identify pool banner odor present"
test2="honey hover catch guard strategy unusual combine chalk basket depth wire donate guilt girl shoot reunion primary master cotton gorilla fork true hurdle charge"
test3="issue inflict actor fix cost path pair misery desert curve model fabric bench funny race sun file diet onion box enforce bridge vibrant artefact"
test4="regular bronze can census powder decrease dinosaur duck foster romance coil mosquito napkin addict dog emerge spare cupboard hello trumpet hero above traffic short"
test5="fox seminar code lunch nasty toilet jacket wear erase rally cute various curtain search text auction man response clutch reopen sister visual between arena"
test6="piano level keep wolf drop body churn demise easily clever dismiss unfold sustain disagree forum wish behind border clump give forward depart age hover"
test7="brave lamp clinic fog year win harsh carpet clarify cushion have fitness impulse prepare shallow unable tornado gesture february that ignore join blade screen"
test8="stove kick uniform boil sting shoot put panda collect inform add inch morning marriage tiny physical mouse beach any method fish window tower upon"
test9="walnut sight evidence food stock lamp tattoo duck damp fringe vehicle useless fee spatial wink arena repeat noodle hard chair flush brave human stone"
test10="fit agree journey solid million erosion case modify wire bachelor pyramid tuition oven reopen sadness tent priority guilt fan know price east ramp reopen"


# if $KEY exists it should be deleted
echo $USER_MNEMONIC | evmosd keys add $KEY --recover --keyring-backend $KEYRING --algo $KEYALGO

echo $test1  | evmosd keys add test1 --recover --keyring-backend $KEYRING --algo $KEYALGO
echo $test2  | evmosd keys add test2 --recover --keyring-backend $KEYRING --algo $KEYALGO
echo $test3  | evmosd keys add test3 --recover --keyring-backend $KEYRING --algo $KEYALGO
echo $test4  | evmosd keys add test4 --recover --keyring-backend $KEYRING --algo $KEYALGO
echo $test5  | evmosd keys add test5 --recover --keyring-backend $KEYRING --algo $KEYALGO
echo $test6  | evmosd keys add test6 --recover --keyring-backend $KEYRING --algo $KEYALGO
echo $test7  | evmosd keys add test7 --recover --keyring-backend $KEYRING --algo $KEYALGO
echo $test8  | evmosd keys add test8 --recover --keyring-backend $KEYRING --algo $KEYALGO
echo $test9  | evmosd keys add test9 --recover --keyring-backend $KEYRING --algo $KEYALGO
echo $test10 | evmosd keys add test10 --recover --keyring-backend $KEYRING --algo $KEYALGO

evmosd config keyring-backend $KEYRING
evmosd config chain-id $CHAINID

# Set moniker and chain-id for Evmos (Moniker can be anything, chain-id must be an integer)
evmosd init $MONIKER --chain-id $CHAINID

# Change parameter token denominations to aevmos
cat $HOME/.evmosd/config/genesis.json | jq '.app_state["staking"]["params"]["bond_denom"]="ahpx"' > $HOME/.evmosd/config/tmp_genesis.json && mv $HOME/.evmosd/config/tmp_genesis.json $HOME/.evmosd/config/genesis.json
cat $HOME/.evmosd/config/genesis.json | jq '.app_state["crisis"]["constant_fee"]["denom"]="ahpx"' > $HOME/.evmosd/config/tmp_genesis.json && mv $HOME/.evmosd/config/tmp_genesis.json $HOME/.evmosd/config/genesis.json

# gov 보증금 시간 수정
cat $HOME/.evmosd/config/genesis.json | jq '.app_state["gov"]["deposit_params"]["min_deposit"][0]["denom"]="ahpx"' > $HOME/.evmosd/config/tmp_genesis.json && mv $HOME/.evmosd/config/tmp_genesis.json $HOME/.evmosd/config/genesis.json
cat $HOME/.evmosd/config/genesis.json | jq '.app_state["gov"]["deposit_params"]["min_deposit"][0]["amount"]="101000000000000000000"' > $HOME/.evmosd/config/tmp_genesis.json && mv $HOME/.evmosd/config/tmp_genesis.json $HOME/.evmosd/config/genesis.json

# 시간을 10분으로 조정
cat $HOME/.evmosd/config/genesis.json | jq '.app_state["gov"]["deposit_params"]["max_deposit_period"]="300s"' > $HOME/.evmosd/config/tmp_genesis.json && mv $HOME/.evmosd/config/tmp_genesis.json $HOME/.evmosd/config/genesis.json
cat $HOME/.evmosd/config/genesis.json | jq '.app_state["gov"]["voting_params"]["voting_period"]="300s"' > $HOME/.evmosd/config/tmp_genesis.json && mv $HOME/.evmosd/config/tmp_genesis.json $HOME/.evmosd/config/genesis.json

cat $HOME/.evmosd/config/genesis.json | jq '.app_state["evm"]["params"]["evm_denom"]="ahpx"' > $HOME/.evmosd/config/tmp_genesis.json && mv $HOME/.evmosd/config/tmp_genesis.json $HOME/.evmosd/config/genesis.json
cat $HOME/.evmosd/config/genesis.json | jq '.app_state["inflation"]["params"]["mint_denom"]="ahpx"' > $HOME/.evmosd/config/tmp_genesis.json && mv $HOME/.evmosd/config/tmp_genesis.json $HOME/.evmosd/config/genesis.json

# 기본 요금(GWEI)
cat $HOME/.evmosd/config/genesis.json | jq '.app_state["feemarket"]["params"]["base_fee"]="21164200000000"' > $HOME/.evmosd/config/tmp_genesis.json && mv $HOME/.evmosd/config/tmp_genesis.json $HOME/.evmosd/config/genesis.json
cat $HOME/.evmosd/config/genesis.json | jq '.app_state["feemarket"]["params"]["base_fee_change_denominator"]="8"' > $HOME/.evmosd/config/tmp_genesis.json && mv $HOME/.evmosd/config/tmp_genesis.json $HOME/.evmosd/config/genesis.json

# inflation 0
cat $HOME/.evmosd/config/genesis.json | jq '.app_state["inflation"]["params"]["mint_denom"]="ahpx"' > $HOME/.evmosd/config/tmp_genesis.json && mv $HOME/.evmosd/config/tmp_genesis.json $HOME/.evmosd/config/genesis.json
cat $HOME/.evmosd/config/genesis.json | jq '.app_state["inflation"]["params"]["inflation_distribution"]["staking_rewards"]="0"' > $HOME/.evmosd/config/tmp_genesis.json && mv $HOME/.evmosd/config/tmp_genesis.json $HOME/.evmosd/config/genesis.json
cat $HOME/.evmosd/config/genesis.json | jq '.app_state["inflation"]["params"]["inflation_distribution"]["usage_incentives"]="0"' > $HOME/.evmosd/config/tmp_genesis.json && mv $HOME/.evmosd/config/tmp_genesis.json $HOME/.evmosd/config/genesis.json
cat $HOME/.evmosd/config/genesis.json | jq '.app_state["inflation"]["params"]["inflation_distribution"]["community_pool"]="0"' > $HOME/.evmosd/config/tmp_genesis.json && mv $HOME/.evmosd/config/tmp_genesis.json $HOME/.evmosd/config/genesis.json

# increase block time (?)
cat $HOME/.evmosd/config/genesis.json | jq '.consensus_params["block"]["time_iota_ms"]="30000"' > $HOME/.evmosd/config/tmp_genesis.json && mv $HOME/.evmosd/config/tmp_genesis.json $HOME/.evmosd/config/genesis.json

# Set gas limit in genesis
cat $HOME/.evmosd/config/genesis.json | jq '.consensus_params["block"]["max_gas"]="10000000"' > $HOME/.evmosd/config/tmp_genesis.json && mv $HOME/.evmosd/config/tmp_genesis.json $HOME/.evmosd/config/genesis.json

# Get close date
#node_address=$(evmosd keys list | grep  "address: " | cut -c12-)
#current_date=$(date -u +"%Y-%m-%dT%TZ")
#cat $HOME/.evmosd/config/genesis.json | jq -r --arg current_date "$current_date" '.app_state["claims"]["params"]["airdrop_start_time"]=$current_date' > $HOME/.evmosd/config/tmp_genesis.json && mv $HOME/.evmosd/config/tmp_genesis.json $HOME/.evmosd/config/genesis.json
# Add account to claims
#amount_to_claim=10000
#cat $HOME/.evmosd/config/genesis.json | jq -r --arg node_address "$node_address" --arg amount_to_claim "$amount_to_claim" '.app_state["claims"]["claims_records"]=[{"initial_claimable_amount":$amount_to_claim, "actions_completed":[false, false, false, false],"address":$node_address}]' > $HOME/.evmosd/config/tmp_genesis.json && mv $HOME/.evmosd/config/tmp_genesis.json $HOME/.evmosd/config/genesis.json

#cat $HOME/.evmosd/config/genesis.json | jq -r --arg current_date "$current_date" '.app_state["claim"]["params"]["duration_of_decay"]="1000000s"' > $HOME/.evmosd/config/tmp_genesis.json && mv $HOME/.evmosd/config/tmp_genesis.json $HOME/.evmosd/config/genesis.json
#cat $HOME/.evmosd/config/genesis.json | jq -r --arg current_date "$current_date" '.app_state["claim"]["params"]["duration_until_decay"]="100000s"' > $HOME/.evmosd/config/tmp_genesis.json && mv $HOME/.evmosd/config/tmp_genesis.json $HOME/.evmosd/config/genesis.json

# Claim module account:
# 0xA61808Fe40fEb8B3433778BBC2ecECCAA47c8c47 || evmos15cvq3ljql6utxseh0zau9m8ve2j8erz89m5wkz
#cat $HOME/.evmosd/config/genesis.json | jq -r --arg amount_to_claim "$amount_to_claim" '.app_state["bank"]["balances"] += [{"address":"evmos15cvq3ljql6utxseh0zau9m8ve2j8erz89m5wkz","coins":[{"denom":"aevmos", "amount":$amount_to_claim}]}]' > $HOME/.evmosd/config/tmp_genesis.json && mv $HOME/.evmosd/config/tmp_genesis.json $HOME/.evmosd/config/genesis.json

# disable produce empty block
if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' 's/create_empty_blocks = true/create_empty_blocks = false/g' $HOME/.evmosd/config/config.toml
  else
    sed -i 's/create_empty_blocks = true/create_empty_blocks = false/g' $HOME/.evmosd/config/config.toml
fi

if [[ $1 == "pending" ]]; then
  if [[ "$OSTYPE" == "darwin"* ]]; then
      sed -i '' 's/create_empty_blocks_interval = "0s"/create_empty_blocks_interval = "30s"/g' $HOME/.evmosd/config/config.toml
      sed -i '' 's/timeout_propose = "3s"/timeout_propose = "30s"/g' $HOME/.evmosd/config/config.toml
      sed -i '' 's/timeout_propose_delta = "500ms"/timeout_propose_delta = "5s"/g' $HOME/.evmosd/config/config.toml
      sed -i '' 's/timeout_prevote = "1s"/timeout_prevote = "10s"/g' $HOME/.evmosd/config/config.toml
      sed -i '' 's/timeout_prevote_delta = "500ms"/timeout_prevote_delta = "5s"/g' $HOME/.evmosd/config/config.toml
      sed -i '' 's/timeout_precommit = "1s"/timeout_precommit = "10s"/g' $HOME/.evmosd/config/config.toml
      sed -i '' 's/timeout_precommit_delta = "500ms"/timeout_precommit_delta = "5s"/g' $HOME/.evmosd/config/config.toml
      sed -i '' 's/timeout_commit = "5s"/timeout_commit = "150s"/g' $HOME/.evmosd/config/config.toml
      sed -i '' 's/timeout_broadcast_tx_commit = "10s"/timeout_broadcast_tx_commit = "150s"/g' $HOME/.evmosd/config/config.toml
  else
      sed -i 's/create_empty_blocks_interval = "0s"/create_empty_blocks_interval = "30s"/g' $HOME/.evmosd/config/config.toml
      sed -i 's/timeout_propose = "3s"/timeout_propose = "30s"/g' $HOME/.evmosd/config/config.toml
      sed -i 's/timeout_propose_delta = "500ms"/timeout_propose_delta = "5s"/g' $HOME/.evmosd/config/config.toml
      sed -i 's/timeout_prevote = "1s"/timeout_prevote = "10s"/g' $HOME/.evmosd/config/config.toml
      sed -i 's/timeout_prevote_delta = "500ms"/timeout_prevote_delta = "5s"/g' $HOME/.evmosd/config/config.toml
      sed -i 's/timeout_precommit = "1s"/timeout_precommit = "10s"/g' $HOME/.evmosd/config/config.toml
      sed -i 's/timeout_precommit_delta = "500ms"/timeout_precommit_delta = "5s"/g' $HOME/.evmosd/config/config.toml
      sed -i 's/timeout_commit = "5s"/timeout_commit = "150s"/g' $HOME/.evmosd/config/config.toml
      sed -i 's/timeout_broadcast_tx_commit = "10s"/timeout_broadcast_tx_commit = "150s"/g' $HOME/.evmosd/config/config.toml
  fi
fi

# Allocate genesis accounts (cosmos formatted addresses)
evmosd add-genesis-account $KEY 90000000000000000000000000ahpx --keyring-backend $KEYRING

evmosd add-genesis-account test1 1000000000000000000000000ahpx --keyring-backend $KEYRING
evmosd add-genesis-account test2 1000000000000000000000000ahpx --keyring-backend $KEYRING
evmosd add-genesis-account test3 1000000000000000000000000ahpx --keyring-backend $KEYRING
evmosd add-genesis-account test4 1000000000000000000000000ahpx --keyring-backend $KEYRING
evmosd add-genesis-account test5 1000000000000000000000000ahpx --keyring-backend $KEYRING
evmosd add-genesis-account test6 1000000000000000000000000ahpx --keyring-backend $KEYRING
evmosd add-genesis-account test7 1000000000000000000000000ahpx --keyring-backend $KEYRING
evmosd add-genesis-account test8 1000000000000000000000000ahpx --keyring-backend $KEYRING
evmosd add-genesis-account test9 1000000000000000000000000ahpx --keyring-backend $KEYRING
evmosd add-genesis-account test10 1000000000000000000000000ahpx --keyring-backend $KEYRING

                                
# Update total supply with claim values
# validators_supply=$(cat $HOME/.evmosd/config/genesis.json | jq -r '.app_state["bank"]["supply"][0]["amount"]')
# Bc is required to add this big numbers
# total_supply=$(bc <<< "$amount_to_claim+$validators_supply")
# total_supply=100000000000000000000010000
# cat $HOME/.evmosd/config/genesis.json | jq -r --arg total_supply "$total_supply" '.app_state["bank"]["supply"][0]["amount"]=$total_supply' > $HOME/.evmosd/config/tmp_genesis.json && mv $HOME/.evmosd/config/tmp_genesis.json $HOME/.evmosd/config/genesis.json

# Sign genesis transaction
# 10% staking
evmosd gentx $KEY 50000000000000000000000000ahpx --keyring-backend $KEYRING --chain-id $CHAINID

# Collect genesis tx
evmosd collect-gentxs

# Run this to ensure everything worked and that the genesis file is setup correctly
evmosd validate-genesis

# cosmos validator 기준 0.1evmos
min_gas_prices="500000000000ahpx"

if [[ $1 == "pending" ]]; then
  echo "pending mode is on, please wait for the first block committed."
fi

# Start the node (remove the --pruning=nothing flag if historical queries are not needed)
evmosd start --pruning=nothing $TRACE --log_level $LOGLEVEL --minimum-gas-prices=$min_gas_prices --json-rpc.api eth,txpool,personal,net,debug,web3
