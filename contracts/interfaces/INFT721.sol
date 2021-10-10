// SPDX-License-Identifier: MIT

pragma solidity >=0.5.0;

interface INFT721 {
    function setRoyaltyFeeRecipient(address _royaltyFeeRecipient) external;

    function setRoyaltyFee(uint8 _royaltyFee) external;

    function setTokenURI(uint256 id, string memory uri) external;

    function setBaseURI(string memory uri) external;

    function mint(
        address to,
        uint256 tokenId,
        bytes calldata data
    ) external;
}
