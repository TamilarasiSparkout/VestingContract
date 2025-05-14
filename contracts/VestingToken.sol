// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract VestingToken {
    IERC20 public token;
    address public beneficiary;//stores the address of the person who will receive the tokens over time
    uint256 public start;//unix timestamp when the vesting process actually begins
    uint256 public cliff;//minimum time the beneficiary must wait to get tokens 
    uint256 public duration;//total time taken to unlock the full amount of tokens 
    uint256 public released;//tracks no.of.tokens to be claimed already by beneficiary

    constructor(
        address _token,
        address _beneficiary,
        uint256 _start,
        uint256 _cliffDuration,
        uint256 _duration
    ){
    beneficiary=_beneficiary;    
    require (_beneficiary != address(0), "Invalid address");
    token=IERC20(_token);
    start=_start;
    cliff=_start + _cliffDuration;
    duration=_duration;
    }
    
    event Tokenreleased(address beneficiary, uint256 Tokens);

    // vestedTokens function is to calculate how many tokens have vested till the current time
    function vestedTokens()public view returns(uint256){
    uint256 totalTokens=token.balanceOf(address(this)) + released;//calculate total amount of tokens
    if(block.timestamp < 0)//If we haven't reached the cliff time yet, nothing is vested, so return 0.
        return 0;
    if(block.timestamp >= start + duration) //if we passed the end of vesting period,every tokens must vested-returns full amount
        return totalTokens;
    return (totalTokens*(block.timestamp -start)) / duration;// linear vesting formula
    // example: total - 1000 tokens available for vesting
        // block.timestamp- current time 1,050,000
        // start          - 1,000,000
        // duration       - 1,72,800 (2days)
        // (1000*(1050000-1000000)) / 172800 = 289 tokens have vested at this point
    }
    
    //releasableTokens function used to calculate how many tokens can withdraw right now(current time)
    function releasableTokens()public view returns(uint256){
        return vestedTokens() - released; // vestedToken (289) - released (ex:89 tokens ) = 200 tokens to withdraw right now
    }
    //release function is to release releasable tokens to beneficiary
    function release() public {
        uint256 Tokens = releasableTokens();// Tokens = 200
        require(Tokens > 0, "NoTokens to release");
        released += Tokens;
        token.transfer(beneficiary, Tokens);
        emit Tokenreleased(beneficiary, Tokens);
    }
 
}