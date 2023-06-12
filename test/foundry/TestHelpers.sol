// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AssertionHelpers} from "./AssertionHelpers.sol";

abstract contract TestHelpers is AssertionHelpers {
    address public user1 = address(11);
    address public user2 = address(12);
    address public user3 = address(13);
    address public user4 = address(14);
    address public owner = address(69);

    modifier asPrankedUser(address user) {
        vm.startPrank(user);
        _;
        vm.stopPrank();
    }
}
