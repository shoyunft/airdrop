// SPDX-License-Identifier: MIT

pragma solidity =0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./interfaces/INFT1155.sol";

contract NFT1155Airdrop is Ownable {
    address public immutable nftContract;
    mapping(uint256 => bool) public tokenIdEnabled;
    mapping(uint256 => mapping(address => bool)) public canClaim;

    event Claim(uint256 indexed tokenId, address indexed account);

    constructor(
        address _nftContract,
        uint256 tokenId,
        address[] memory accounts
    ) {
        nftContract = _nftContract;
        tokenIdEnabled[tokenId] = true;
        for (uint256 i = 0; i < accounts.length; i++) {
            canClaim[tokenId][accounts[i]] = true;
        }
    }

    function enable(uint256 tokenId, address[] memory accounts) external onlyOwner {
        require(!tokenIdEnabled[tokenId], "DUPLICATE_TOKEN_ID");

        for (uint256 i = 0; i < accounts.length; i++) {
            canClaim[tokenId][accounts[i]] = true;
        }
    }

    function setRoyaltyFeeRecipient(address _royaltyFeeRecipient) external onlyOwner {
        INFT1155(nftContract).setRoyaltyFeeRecipient(_royaltyFeeRecipient);
    }

    function setRoyaltyFee(uint8 _royaltyFee) external onlyOwner {
        INFT1155(nftContract).setRoyaltyFee(_royaltyFee);
    }

    function setURI(uint256 tokenId, string memory uri) external onlyOwner {
        INFT1155(nftContract).setURI(tokenId, uri);
    }

    function setBaseURI(string memory baseURI) external onlyOwner {
        INFT1155(nftContract).setBaseURI(baseURI);
    }

    function claim(uint256 tokenId) external {
        require(canClaim[tokenId][msg.sender], "FORBIDDEN");

        INFT1155(nftContract).mint(msg.sender, tokenId, 1, "");
        canClaim[tokenId][msg.sender] = false;

        emit Claim(tokenId, msg.sender);
    }
}
