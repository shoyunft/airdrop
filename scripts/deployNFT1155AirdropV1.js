const { ethers } = require("hardhat");
const readlineSync = require("readline-sync");

async function main() {
    const contract = readlineSync.question("Contract Address: ");
    const merkleRoot = readlineSync.question("Merkle Root: ");
    const tokenId = readlineSync.question("Token ID: ");

    const NFT1155Airdrop = await ethers.getContractFactory("NFT1155AirdropV1");
    const airdrop = await NFT1155Airdrop.deploy(contract, merkleRoot, tokenId);
    await airdrop.deployed();

    console.log("NFT1155Airdrop deployed to:", airdrop.address);
}

main()
    .then(() => process.exit(0))
    .catch(error => {
        console.error(error);
        process.exit(1);
    });
