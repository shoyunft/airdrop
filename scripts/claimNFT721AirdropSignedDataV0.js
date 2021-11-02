const { ethers } = require("hardhat");
const readlineSync = require("readline-sync");

async function main() {
    const contract = readlineSync.question("Contract Address: ");
    const merkleRoot = readlineSync.question("Merkle Root: ");
    const merkleProof = JSON.parse(readlineSync.question("Merkle Proof: "));
    const leaf = readlineSync.question("Leaf Data: ");

    const [deployer] = await ethers.getSigners();
    const signature = await deployer.signMessage(ethers.utils.arrayify(ethers.utils.id(leaf)));
    const { v, r, s } = ethers.utils.splitSignature(signature);
    const data = ethers.utils.defaultAbiCoder.encode(
        ["bytes", "uint8", "bytes32", "bytes32"],
        [ethers.utils.toUtf8Bytes(leaf), v, r, s]
    );
    const airdrop = await ethers.getContractAt("NFT721AirdropSignedDataV0", contract);
    const tx = await airdrop.claim(merkleRoot, merkleProof, data);
    console.log("claimed: " + tx.hash);
}

main()
    .then(() => process.exit(0))
    .catch(error => {
        console.error(error);
        process.exit(1);
    });
