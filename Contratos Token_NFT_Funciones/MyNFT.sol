//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyNFT is ERC721, Ownable {

  struct NFTMetadata {
    string metadata; 
  }

  mapping(uint256 => NFTMetadata) public nftMetadata;

  constructor() ERC721("MyNFT", "NFT") Ownable(msg.sender) {}

  function mint(address to, uint256 tokenId) public {
    _mint(to, tokenId);
  }
  
  function updateMetadata(uint256 tokenId, string memory _metadata) public onlyOwner {
    nftMetadata[tokenId].metadata = _metadata;
  }

  function getMetadata(uint256 tokenId) public view returns (string memory) {
    return nftMetadata[tokenId].metadata;
  }

}