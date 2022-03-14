<!--
order: 1
-->

# Block Explorers

Read about the different types of block explorers on Evmos. {synopsis}

## Introduction

Blockchain explorers allow users to query the blockchain for data. Explorers are often compared to search engines for the blockchain. By using an explorer, users can search and track balances, transactions, contracts, and other broadcasted data to the blockchain.

<<<<<<< HEAD
Evmos offers two types block explorers: an EVM explorer and a Cosmos explorer. Each explorer queries data respective to their environment with the EVM explorers querying Ethereum-formatted data (blocks, transactions, accounts, smart contracts etc) and the Cosmos explorers querying Cosmos-formatted data (Cosmoss and IBC transactions, blocks, accounts, module data, etc).

## EVM-based

### Evmos EVM Explorer (Blockscout)

![Blockscout](./img/blockscout.png)

The [Evmos EVM explorer](https://evm.evmos.org/) is the EVM explorer for Evmos. The EVM explorer allows users to view Evmos EVM activity such as smart contract creations, interactions, token transfers, and other types of transactions. Users can also view Evmos and ERC-20 token balances through the Evmos EVM Explorer

## Cosmos-based

### Evmos Cosmos-based Explorer (Big Dipper)

![Big Dipper](./img/big_dipper.png)

The [Evmos Cosmos-based explorer](https://explorer.evmos.org/) is the Cosmos explorer for Evmos. The Cosmos-based explorer allows users to view Evmos activity within the Cosmos ecosystem. This explorer allows users to query transactions, delegations, IBC token transfers, and other Cosmos-related Evmos activity. Users can also view tokeneconomics and governance data using the Evmos Cosmos-based explorer.
=======
Evmos offers two types block explorers: an EVM explorer and a Cosmos explorer. Each explorer queries data respective to their environment with the EVM explorers querying Ethereum-formatted data (blocks, transactions, accounts, smart contracts, etc) and the Cosmos explorers querying Cosmos-formatted data (Cosmos and IBC transactions, blocks, accounts, module data, etc).

### List of Block Explorers

Below is a list of public block explorers that support Evmos Mainnet and Testnet:

:::: tabs
::: tab Mainnet

|                      | Category | URL                    |
| -------------------- | -------- | ---------------------- |
| Blockscout  | `evm`    | [evm.evmos.org](https://evm.evmos.org/)                       |
| Mintscan   | `cosmos` | [explorer.evmos.org](https://explorer.evmos.org/) |
:::
::: tab Testnet

|                      | Category | URL                    |
| -------------------- | -------- | ---------------------- |
| BigDipper  | `cosmos`    | [testnet.bigdipper.live](https://testnet.evmos.bigdipper.live/)                       |
| Blockscout  | `evm`    | [evm.evmos.dev](https://evm.evmos.dev/)                       |
| Evmostats  | `cosmos`    | [evm.evmos.dev](https://testnet.evmostats.io/)                       |
| Mintscan   | `cosmos` | [mintscan.io/evmos/](https://www.mintscan.io/evmos/) |
:::
::::
>>>>>>> tharsis/release/v2.0.x
