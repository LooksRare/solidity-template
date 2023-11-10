// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {CommonBase} from "forge-std/Base.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import {StdUtils} from "forge-std/StdUtils.sol";

contract InvariantTestHelpers is CommonBase, StdCheats, StdUtils {
    address[100] internal actors;
    address internal currentActor;
    bool internal callsMustBeValid;
    mapping(bytes => uint256) internal calls;

    constructor() {
        _populateActors();
        _setCallsMustBeValid();
    }

    modifier useActor(uint256 actorIndexSeed) {
        currentActor = actors[bound(actorIndexSeed, 0, 99)];
        vm.startPrank(currentActor);
        _;
        vm.stopPrank();
    }

    modifier countCall(bytes memory key) {
        calls[key]++;
        _;
    }

    function _populateActors() internal {
        for (uint256 i; i < 100; i++) {
            actors[i] = address(uint160(uint256(keccak256(abi.encodePacked(i)))));
        }
    }

    function _setCallsMustBeValid() internal {
        callsMustBeValid = vm.envBool("FOUNDRY_INVARIANT_FAIL_ON_REVERT");
    }
}
