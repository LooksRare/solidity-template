// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";

// Scripting tool
import {Script} from "forge-std/Script.sol";
import {console2} from "forge-std/console2.sol";
import {stdJson} from "forge-std/StdJson.sol";

contract Deployment is Script {
    using stdJson for string;

    function run() external {
        uint256 deployerPrivateKey = vm.envUint(_getString("privateKeyName"));

        vm.startBroadcast(deployerPrivateKey);

        vm.stopBroadcast();
    }

    function _getNetworkConfig() private view returns (string memory json) {
        string memory root = vm.projectRoot();
        string memory path = string.concat(root, "/scripts/deployment/NetworkConfig.json");
        json = vm.readFile(path);
    }

    function _getAddress(string memory key) private view returns (address) {
        return
            abi.decode(
                _getNetworkConfig().parseRaw(string(abi.encodePacked(".", Strings.toString(block.chainid), ".", key))),
                (address)
            );
    }

    function _getString(string memory key) private view returns (string memory) {
        return
            abi.decode(
                _getNetworkConfig().parseRaw(string(abi.encodePacked(".", Strings.toString(block.chainid), ".", key))),
                (string)
            );
    }

    function _getUint64(string memory key) private view returns (uint64) {
        return
            abi.decode(
                _getNetworkConfig().parseRaw(string(abi.encodePacked(".", Strings.toString(block.chainid), ".", key))),
                (uint64)
            );
    }

    function _getUint16(string memory key) private view returns (uint16) {
        return
            abi.decode(
                _getNetworkConfig().parseRaw(string(abi.encodePacked(".", Strings.toString(block.chainid), ".", key))),
                (uint16)
            );
    }

    function _getBytes32(string memory key) private view returns (bytes32) {
        return
            abi.decode(
                _getNetworkConfig().parseRaw(string(abi.encodePacked(".", Strings.toString(block.chainid), ".", key))),
                (bytes32)
            );
    }
}
