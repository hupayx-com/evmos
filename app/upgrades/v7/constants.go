package v7

const (
	// UpgradeName is the shared upgrade plan name for mainnet and testnet
	UpgradeName = "v7.0.0"
	// MainnetUpgradeHeight defines the Evmos mainnet block height on which the upgrade will take place
	MainnetUpgradeHeight = 1
	// TestnetUpgradeHeight defines the Evmos testnet block height on which the upgrade will take place
	TestnetUpgradeHeight = 1
	// UpgradeInfo defines the binaries that will be used for the upgrade
	UpgradeInfo = `'{"binaries":{"darwin/arm64":"https://github.com/evmos/evmos/releases/download/v7.0.0-hupayx/evmos_7.0.0-hupayx_Darwin_arm64.tar.gz","darwin/x86_64":"https://github.com/evmos/evmos/releases/download/v7.0.0-hupayx/evmos_7.0.0-hupayx_Darwin_x86_64.tar.gz","linux/arm64":"https://github.com/evmos/evmos/releases/download/v7.0.0-hupayx/evmos_7.0.0-hupayx_Linux_arm64.tar.gz","linux/x86_64":"https://github.com/evmos/evmos/releases/download/v7.0.0-hupayx/evmos_7.0.0-hupayx_Linux_x86_64.tar.gz","windows/x86_64":"https://github.com/evmos/evmos/releases/download/v7.0.0-hupayx/evmos_7.0.0-hupayx_Windows_x86_64.zip"}}'`

	// FaucetAddressFrom is the inaccessible secp address of the Testnet Faucet
	FaucetAddressFrom = "evmos1lv6dkwyu6z9f7qlllas63aehk9k7h9ncvz2at5"
	// FaucetAddressTo is the new eth_secp address of the Testnet Faucet
	FaucetAddressTo = "evmos1c2s59ru8tkrm653qy4dw424cywm7hvy3f94lvj"

	// ContributorAddrFrom is the lost address of an early contributor
	ContributorAddrFrom = "evmos1s9q78sjy3mn0lm2al4hst72sk9j69wjczjvxkk"
	// ContributorAddrTo is the new address of an early contributor
	ContributorAddrTo = "evmos1laelaksgu24lth86gguqssnwj587tn6draseyw"
)
