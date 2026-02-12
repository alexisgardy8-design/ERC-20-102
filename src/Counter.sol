// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.24;
import {IExerciseSolution} from "../interfaces/IExerciseSolution.sol";
import {IERC20} from "../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import {ERC20Claimable} from "../interfaces/IERC20Clamable.sol";
import {IERC20Mintable} from "../interfaces/IERC20Mintable.sol";

contract Solution is IExerciseSolution  {
    mapping(address => uint256) public tokensIncustody;
    function claimTokensOnBehalf() external override {
        ERC20Claimable teacherERC20 = ERC20Claimable(0xD829b447AbABDb689C1F6DC81CCe3d29b37c5992);
        uint256 claimedAmount;
        claimedAmount = teacherERC20.claimTokens();
        tokensIncustody[msg.sender] += claimedAmount;

    } 
    function tokensInCustody(address caller) external override returns (uint256) { 
        return tokensIncustody[caller];
    } 
    function withdrawTokens( uint256 amountToWithdraw ) external override returns (uint256) { 
        ERC20Claimable teacherERC20 = ERC20Claimable(0xD829b447AbABDb689C1F6DC81CCe3d29b37c5992); 
        IERC20 token = IERC20(address(teacherERC20)); 
        IERC20Mintable exo = IERC20Mintable(address(0x489fE72A6D4a2a759001cc40eA257E5C210D75fA));
        exo.burn(amountToWithdraw);
        tokensIncustody[msg.sender] -= amountToWithdraw;
        return amountToWithdraw;
    } 
    function depositTokens(uint256 amountToDeposit) external override  { 
        ERC20Claimable teacherERC20 = ERC20Claimable(0xD829b447AbABDb689C1F6DC81CCe3d29b37c5992); 
        IERC20 token = IERC20(address(teacherERC20)); 
        token.transferFrom(msg.sender, address(this), amountToDeposit);
        IERC20Mintable exo = IERC20Mintable(address(0x489fE72A6D4a2a759001cc40eA257E5C210D75fA));
        tokensIncustody[msg.sender] += amountToDeposit; 
        exo.mint(msg.sender, amountToDeposit);

       

       
    } 
    function getERC20DepositAddress() external override returns (address) {
        address ERC20Sol = address(0x489fE72A6D4a2a759001cc40eA257E5C210D75fA);
        return ERC20Sol;
    }
    receive() external payable {}

}
