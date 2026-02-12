// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import {Solution} from "../src/Counter.sol";
import {Token} from "../src/ERC20Mintable.sol";

contract CounterScript is Script {
    Token public counter;
    Solution public solution;
    uint256 private deployerKey = vm.envUint("PRIVATE_KEY");

    function setUp() public {}

    function run() public {
        vm.startBroadcast(deployerKey);

        solution = new Solution();

        vm.stopBroadcast();
    }
}
