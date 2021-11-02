// SPDX-License-Identifier: MIT

pragma solidity =0.8.3;

import "./BaseNFT721Airdrop.sol";

contract NFT721AirdropV2 is BaseNFT721Airdrop {
    constructor(
        address _nftContract,
        bytes32 merkleRoot,
        uint256 fromTokenId,
        uint256 length
    ) BaseNFT721Airdrop(_nftContract, merkleRoot, fromTokenId, length) {
        // Empty
    }

    function hash(bytes memory) public override view returns (bytes32) {
        return keccak256(abi.encodePacked(msg.sender));
    }

    function _verify(
        bytes32 merkleRoot,
        bytes32[] memory merkleProof,
        bytes memory
    ) internal view override {
        require(verify(merkleRoot, keccak256(abi.encodePacked(msg.sender)), merkleProof), "SHOYU: INVALID_PROOF");
    }
}
