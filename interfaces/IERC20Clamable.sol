// SPDX-License-Identifier: MIT

pragma solidity >=0.8.24;

import "../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "../lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol";

interface ERC20Claimable  {
function claimTokens() external returns (uint256);
 }