const { ethers } = require("hardhat");
const readlineSync = require("readline-sync");

async function main() {
    const contract = readlineSync.question("Contract Address: ");
    const merkleRoot = readlineSync.question("Merkle Root: ");
    const fromTokenId = readlineSync.question("From Token ID: ");
    const length = readlineSync.question("Length: ");

    const NFT721Airdrop = await ethers.getContractFactory("NFT721AirdropV2");
    const airdrop = NFT721Airdrop.attach(contract);
    await airdrop.addMerkleRoot(merkleRoot, fromTokenId, length, {
        gasPrice: ethers.BigNumber.from(10).pow(9).mul(160),
    });

    console.log("NFT721Airdrop merkle root added");
}

main()
    .then(() => process.exit(0))
    .catch(error => {
        console.error(error);
        process.exit(1);
    });
