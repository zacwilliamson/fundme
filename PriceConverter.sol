// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {

    function getPrice() internal view returns(uint256){
        // address 0x1a81afB8146aeFfCFc5E50e8479e826E7D55b910
        // ABI 
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x1a81afB8146aeFfCFc5E50e8479e826E7D55b910);
        (, int256 answer,,,) = priceFeed.latestRoundData();
        // Price of ETH in terms of USD
        // return uint256(answer * 1e10);
        return uint256(answer);

    }

    function getConversionRate(uint256 ethAmount) internal view returns(uint256){
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }

    function getVersion() internal view returns (uint256){
        return AggregatorV3Interface(0x1a81afB8146aeFfCFc5E50e8479e826E7D55b910).version();
    }

}