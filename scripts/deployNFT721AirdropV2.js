const { ethers } = require("hardhat");
const readlineSync = require("readline-sync");

async function main() {
    const contract = readlineSync.question("Contract Address: ");
    const merkleRoot = readlineSync.question("Merkle Root: ");
    const fromTokenId = readlineSync.question("From Token ID: ");
    const length = readlineSync.question("Length: ");

    const NFT721Airdrop = await ethers.getContractFactory("NFT721AirdropV2");
    const airdrop = await NFT721Airdrop.deploy(contract, merkleRoot, fromTokenId, length);
    await airdrop.deployed();

    console.log("NFT721Airdrop deployed to:", airdrop.address);
}

main()
    .then(() => process.exit(0))
    .catch(error => {
        console.error(error);
        process.exit(1);
    });
