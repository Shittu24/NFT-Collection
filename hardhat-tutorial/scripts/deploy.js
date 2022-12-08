const {ethers} = require ("hardhat")
require("dotenv").config({path: ".env"})
const {WHITELIST_CONTRACT_ADDRESS, METADATA_URL} = require("../constants")

async function main() {
  // Address of the whitelist contract that was previously deployed
  const whitelistContract = WHITELIST_CONTRACT_ADDRESS

  // URL from where we can extract the metadata for a Crypro Dev NFT
  const metadataURL = METADATA_URL
  // To deploy the contract 
  const cryptoDevsContract = await ethers.getContractFactory("CryptoDevs")
  const deploycryptoDevsContract = await cryptoDevsContract.deploy(metadataURL, whitelistContract)
 // await deploycryptoDevsContract.deployed()

 // Print the address of the deployed contract
 console.log("Crypto Devs Contract Deployed To:", deploycryptoDevsContract.address)

}


// Call the main function and catch if there is any error
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error)
    process.exit(1)
  })