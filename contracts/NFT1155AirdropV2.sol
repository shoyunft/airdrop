// SPDX-License-Identifier: MIT

pragma solidity =0.8.3;

import "@shoyunft/contracts/contracts/interfaces/INFT1155Metadata.sol";
import "./NFT1155AirdropV1.sol";

contract NFT1155AirdropV2 is NFT1155AirdropV1 {
    constructor(
        address _nftContract,
        bytes32 _merkleRoot,
        uint256 _tokenId
    ) NFT1155AirdropV1(_nftContract, _merkleRoot, _tokenId) {
        // Empty
    }

    function name() external view returns (string memory) {
        return INFT1155Metadata(nftContract).name();
    }

    function setName(string calldata _name) external {
        INFT1155Metadata(nftContract).setName(_name);
    }
}
