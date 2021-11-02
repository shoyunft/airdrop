// SPDX-License-Identifier: MIT

pragma solidity =0.8.3;

import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "./BaseNFT721Airdrop.sol";

contract NFT721AirdropSignedDataV0 is BaseNFT721Airdrop {
    constructor(
        address _nftContract,
        bytes32 merkleRoot,
        uint256 fromTokenId,
        uint256 length
    ) BaseNFT721Airdrop(_nftContract, merkleRoot, fromTokenId, length) {
        // Empty
    }

    function hash(bytes memory data) public override view returns (bytes32) {
        return keccak256(data);
    }

    function _verify(
        bytes32 merkleRoot,
        bytes32[] memory merkleProof,
        bytes memory data
    ) internal view override {
        (bytes memory message, uint8 v, bytes32 r, bytes32 s) = abi.decode(data, (bytes, uint8, bytes32, bytes32));
        bytes32 leaf = keccak256(message);
        address signer = ECDSA.recover(ECDSA.toEthSignedMessageHash(leaf), v, r, s);
        require(signer == owner(), "SHOYU: UNAUTHORIZED");
        require(verify(merkleRoot, leaf, merkleProof), "SHOYU: INVALID_PROOF");
    }
}
