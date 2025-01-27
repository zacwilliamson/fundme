// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

// Get funds from user
// Withdraw funds
// Set a minimum funding value in USD'
// global variables in Solidity https://docs.soliditylang.org/en/latest/units-and-global-variables.html#block-and-transaction-properties

contract FundMe {

    uint256 public minimumUsd = 5e18;

    address[] public funders;
    mapping(address => uint256 amountFunded) public addressToAmountFunded;

    // 'payable' makes the function fundable.
    function fund() public payable {
        // allow users to send $5
        require(getConversionRate(msg.value) >= minimumUsd, "Didn't send enough ETH"); // 1e18 = 1 ETH = 1000000000000000000 wei = 1 * 10 ** 18
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;

        // What is a revert?
        // Undo any actions that have been done, and send the remaining gas back
    }

    function getPrice() public view returns(uint256){
        // address 0x1a81afB8146aeFfCFc5E50e8479e826E7D55b910
        // ABI 
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x1a81afB8146aeFfCFc5E50e8479e826E7D55b910);
        (, int256 answer,,,) = priceFeed.latestRoundData();
        // Price of ETH in terms of USD
        // return uint256(answer * 1e10);
        return uint256(answer);

    }

    function getConversionRate(uint256 ethAmount) public view returns(uint256){
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }

    function withdraw() public {

    }
}
