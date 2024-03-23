// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract BasicCalculator {
    function add(uint256 a, uint256 b) public pure returns (uint256) {
        return a + b;
    }

    function sub(uint256 a, uint256 b) public pure returns (uint256) {
        require(a > b, "First Number Should Be Greater:");
        return a - b;
    }

    function multiply(uint256 a, uint256 b) public pure returns (uint256) {
        return a * b;
    }

    function division(uint256 a, uint256 b) public pure returns (uint256) {
        require(a > b, "First Number Should Be Greater:");
        return a / b;
    }
}
