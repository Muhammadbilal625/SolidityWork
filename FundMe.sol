// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import {PriceConverter} from "./PriceConverter.sol";

error NotOwner();
contract FundMe{
    using PriceConverter for uint256;

    mapping(address =>uint256) public addressToAmountFunded;
    address[] public funders;
    address public  i_owner;
    uint256 public constant MINIMUM_USD=5*10**18;

    constructor(){
        i_owner=msg.sender;
    }
    function fund() public payable{
        require(msg.value.getConversionRate()>=MINIMUM_USD,"You Need To Spend More ETH");
        addressToAmountFunded[msg.sender]+=msg.value;
        funders.push(msg.sender);
  }
  
    function getVersion() public view returns(uint256){
        AggregatorV3Interface PriceFeed= AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return PriceFeed.version();
    }

      modifier onlyOwner {
        // require(msg.sender == owner);
        if (msg.sender != i_owner) revert NotOwner();
        _;
    }
    function withdraw() public onlyOwner{
        for(uint funderIndex=0;funderIndex<funders.length;funderIndex++){
            address funder=funders[funderIndex];
            addressToAmountFunded[funder]=0;

        }
        funders =new address[](0);
         // // transfer
        // payable(msg.sender).transfer(address(this).balance);
        
        // // send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send failed");
        (bool callSuccess,)=payable(msg.sender).call{value:address(this).balance}("");
        require(callSuccess,"Call Failed");


        }
        receive() external payable {
            fund();
         }

         fallback()external payable{
            fund();
         }
    }


