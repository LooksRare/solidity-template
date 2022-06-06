// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "../../lib/forge-std/src/Test.sol";

abstract contract TestHelpers is Test {
    address public user1 = address(1);
    address public user2 = address(2);
    address public user3 = address(3);
    address public user4 = address(4);

    modifier asPrankedUser(address user) {
        vm.startPrank(user);
        _;
        vm.stopPrank();
    }
}
