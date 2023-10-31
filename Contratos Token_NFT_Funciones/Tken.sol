//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol"; 
import "@openzeppelin/contracts/access/Ownable.sol";

contract Tken is ERC20, Ownable {

  constructor(address initialOwner) ERC20("Tken", "TKEN") Ownable(initialOwner) {}

  uint public fee = 1;

  function myTransfer(address from, address to, uint256 amount) internal {
    
    uint feeAmount = (amount * fee) / 100;

    super._transfer(from, to, amount - feeAmount);

  }

  function setFee(uint newFee) external onlyOwner {
    fee = newFee;
  }

  function mint(address account, uint256 amount) external {
    _mint(account, amount);
  }

}