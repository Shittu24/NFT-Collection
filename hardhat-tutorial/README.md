# NFT COLLECTION DApp WITH LEARNWEB3DAO SOPHOMORE TRACK

This project demonstrates a NFT collection smart contract built with hardhat and ethers. It alows selected contract addresses to get
whitelisted for NFT collection and allow them to participate in the presale of the NFT collection. Addresses that are not whitelisted
will also be able to nuy NFTs only after the presale has ended.

The frontend of this contract was built with NextJS that provides a simple user interface to allow users to interact with the contract.
Firstly, you need to connect your wallet and if your address is whitelisted, you can participate in the presale of the NFT collection
ELSE you need to wait for the presale to end before you can buy Crypto Devs NFT.

The contract is hosted with vercel app on:
<b> </b>

Try running some of the following tasks on the contract (hardhat-tutorial) directory:

```shell
yarn hardhat help
yarn hardhat test
yarn hardhat node
yarn hardhat run scripts/deploy.js
yarn hardhat run scripts/deploy.js --network goerli
```

## Getting Started With The Frontend

First, run the development server:

```bash
npm run dev
# or
yarn dev
```

Open [http://localhost:3000](http://localhost:3000) with your browser to see the result.