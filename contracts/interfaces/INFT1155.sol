// SPDX-License-Identifier: MIT

pragma solidity >=0.5.0;

interface INFT1155 {
    function setRoyaltyFeeRecipient(address _royaltyFeeRecipient) external;

    function setRoyaltyFee(uint8 _royaltyFee) external;

    function setURI(uint256 id, string memory uri) external;

    function setBaseURI(string memory baseURI) external;

    function mint(
        address to,
        uint256 tokenId,
        uint256 amount,
        bytes calldata data
    ) external;
}
