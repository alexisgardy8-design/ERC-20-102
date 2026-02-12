// SPDX-License-Identifier: MIT

pragma solidity >=0.8.24;

import "../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import {IERC20Mintable} from "../interfaces/IERC20Mintable.sol"; 
import {IExerciseSolution} from "../interfaces/IExerciseSolution.sol"; 
import {ERC20Claimable} from "../interfaces/IERC20Clamable.sol";
import {IERC20} from "../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

contract Token is IERC20, IERC20Mintable {
    mapping (address => bool) public minters;
    mapping (address => IExerciseSolution) public mintlist;
    mapping (address => uint256) private _balances; 
    mapping (address => mapping (address => uint256)) private _allowances; 
    uint256 private _totalSupply; 
    
   

    function setMinter(address minterAddress, bool isMinter) public {
        minters[minterAddress] = isMinter;
        mintlist[minterAddress] = IExerciseSolution(minterAddress);
    }

    function mint(address toAddress, uint256 amount) external {
        require(minters[msg.sender], "Not a minter"); 
        _balances[toAddress] += amount; 
        _totalSupply += amount; 
        emit Transfer(address(0), toAddress, amount);
    }

    function burn(uint256 amount) external {
        require(_balances[msg.sender] >= amount, "Not enough balance to burn"); 
        _balances[msg.sender] -= amount; 
        _totalSupply -= amount; 
        emit Transfer(msg.sender, address(0), amount);
    }

    function isMinter(address minterAddress) external returns (bool) {
        return minters[minterAddress];
    }

    function totalSupply() external view returns (uint256){return _totalSupply; }

    function balanceOf(address account) external view returns (uint256){return _balances[account];}

    
    function transfer(address to, uint256 value) external returns (bool){require(_balances[msg.sender] >= value, "Not enough balance"); _balances[msg.sender] -= value; _balances[to] += value; emit Transfer(msg.sender, to, value); return true; }

    
    function allowance(address owner, address spender) external view returns (uint256){return _allowances[owner][spender];}

    
    function approve(address spender, uint256 value) external returns (bool){_allowances[msg.sender][spender] = value; emit Approval(msg.sender, spender, value); return true;}

    
    function transferFrom(address from, address to, uint256 value) external returns (bool){require(_balances[from] >= value, "Not enough balance"); require(_allowances[from][msg.sender] >= value, "Not enough allowance"); _balances[from] -= value; _balances[to] += value; _allowances[from][msg.sender] -= value; emit Transfer(from, to, value); return true;}

    receive() external payable {}
}