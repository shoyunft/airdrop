const { ethers } = require("hardhat");
const readlineSync = require("readline-sync");

async function main() {
    const contract = readlineSync.question("Contract Address: ");
    const merkleRoot = readlineSync.question("Merkle Root: ");
    const merkleProof = JSON.parse(readlineSync.question("Merkle Proof: "));

    const airdrop = await ethers.getContractAt("NFT721AirdropSignedDataV0", contract);
    const tx = await airdrop.claim(merkleRoot, merkleProof, "0x");
    console.log("claimed: " + tx.hash);
}

main()
    .then(() => process.exit(0))
    .catch(error => {
        console.error(error);
        process.exit(1);
    });
