//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract DigitalWill is ERC20 {

  // Estructura para representar a cada heredero
  struct Inheritor {
    address account; // Dirección del heredero 
    uint256 allocation; // Porcentaje de asignación (0-100)
  }

  // Array para guardar los herederos
  Inheritor[] public inheritors;

  // Mapping para marcar si una dirección está fallecida
  mapping(address => bool) public isDeceased;

  // Mapping para palabra clave y dirección de liberación
  mapping(string => address) public releaseKeywords;

  // Constructor - crea el token ERC20
  constructor() ERC20("DigitalWill", "WILL") {
    _mint(msg.sender, 10000 * 10**decimals());
  }

  // Permite configurar los herederos y sus porcentajes
  function setInheritors(address[] memory _inheritors, uint256[] memory _allocations) public {
    require(_inheritors.length == _allocations.length, "Arrays length mismatch");

    for(uint i = 0; i < _inheritors.length; i++) {
      inheritors.push(Inheritor(_inheritors[i], _allocations[i]));
    }
  }

  // Permite configurar palabra clave y dirección de liberación
  function setReleaseKeyword(string memory _keyword, address _recipient) public {
    releaseKeywords[_keyword] = _recipient;
  }

  // Permite marcar una cuenta como fallecida y distribuir sus tokens
  function recordDeath() public {
    require(isDeceased[msg.sender] == false, "Already recorded");

    isDeceased[msg.sender] = true;
    
    uint256 balance = balanceOf(msg.sender);

    for(uint i = 0; i < inheritors.length; i++) {
      _transfer(msg.sender, inheritors[i].account, balance * inheritors[i].allocation / 100);
    }
  }

  // Libera tokens si se envía la palabra clave correcta
  function releaseTokens(string memory _keyword) public {
    require(releaseKeywords[_keyword] != address(0), "Invalid keyword");

    uint256 amount = 1000 * 10**decimals();
    
    _transfer(msg.sender, releaseKeywords[_keyword], amount);
  }

}