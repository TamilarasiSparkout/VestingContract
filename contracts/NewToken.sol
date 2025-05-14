// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NewToken is ERC20, Ownable{
    constructor() ERC20("NewToken", "NWT") Ownable(msg.sender){
        uint256 initialSupply= 1000000*10**decimals();
        _mint(msg.sender, initialSupply);
        
    }
}