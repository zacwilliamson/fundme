// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {PriceConverter} from "./PriceConverter.sol";

// Get funds from user
// Withdraw funds
// Set a minimum funding value in USD'
// global variables in Solidity https://docs.soliditylang.org/en/latest/units-and-global-variables.html#block-and-transaction-properties

contract FundMe {
    using PriceConverter for uint256;

    uint256 public minimumUsd = 5e18;

    address[] public funders;
    mapping(address => uint256 amountFunded) public addressToAmountFunded;

    function fund() public payable {
        require(msg.value.getConversionRate() >= minimumUsd, "Didn't send enough ETH"); // 1e18 = 1 ETH = 1000000000000000000 wei = 1 * 10 ** 18
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
    }

    function withdraw() public {

    }
}
