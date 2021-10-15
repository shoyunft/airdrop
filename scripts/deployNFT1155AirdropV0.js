const { ethers } = require("hardhat");
const readlineSync = require("readline-sync");

module.exports = async () => {
    const contract = readlineSync.prompt("Contract Address: ");
    const merkleRoot = readlineSync.prompt("Merkle Root: ");
    const toTokenId = readlineSync.prompt("To Token ID: ");
    const NFT721Airdrop = ethers.getContractFactory("NFT721Airdrop");

    const airdrop = await NFT721Airdrop.deploy(contract, merkleRoot, toTokenId);
    await airdrop.deployed();

    console.log("NFT721Airdrop deployed to:", airdrop.address);
};
