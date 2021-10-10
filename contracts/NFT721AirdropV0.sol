// SPDX-License-Identifier: MIT

pragma solidity =0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./interfaces/INFT721.sol";

contract NFT721Airdrop is Ownable {
    address public immutable nftContract;
    mapping(address => bool) public canClaim;
    uint256 public lastTokenId;

    event Claim(uint256 indexed tokenId, address indexed account);

    constructor(address _nftContract, address[] memory accounts) {
        nftContract = _nftContract;
        for (uint256 i = 0; i < accounts.length; i++) {
            canClaim[accounts[i]] = true;
        }
    }

    function enable(address[] memory accounts) external onlyOwner {
        for (uint256 i = 0; i < accounts.length; i++) {
            canClaim[accounts[i]] = true;
        }
    }

    function setRoyaltyFeeRecipient(address _royaltyFeeRecipient) external onlyOwner {
        INFT721(nftContract).setRoyaltyFeeRecipient(_royaltyFeeRecipient);
    }

    function setRoyaltyFee(uint8 _royaltyFee) external onlyOwner {
        INFT721(nftContract).setRoyaltyFee(_royaltyFee);
    }

    function setTokenURI(uint256 tokenId, string memory uri) external onlyOwner {
        INFT721(nftContract).setTokenURI(tokenId, uri);
    }

    function setBaseURI(string memory baseURI) external onlyOwner {
        INFT721(nftContract).setBaseURI(baseURI);
    }

    function claim() external {
        require(canClaim[msg.sender], "FORBIDDEN");

        uint256 tokenId = lastTokenId;
        INFT721(nftContract).mint(msg.sender, tokenId, "");
        canClaim[msg.sender] = false;
        lastTokenId++;

        emit Claim(tokenId, msg.sender);
    }
}
