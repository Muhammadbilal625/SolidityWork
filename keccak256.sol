// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract HashFunction{
    function hash( string memory _text,uint256 _num,address _addr)
    external pure returns(bytes32)
    {
        return keccak256(abi.encodePacked(_text,_num,_addr));
    }

    function collision(string memory text,string memory another_text) external pure 
    returns(bytes32){
        return  keccak256(abi.encodePacked(text,another_text));

    }
}
contract GuessTheMagicWord{
    bytes32 public answer=  0x60298f78cc0b47170ba79c10aa3851d7648bd96f2f8e46a19dbc777c36fb0c00;

    function guess(string memory word) public view returns(bool){
        return keccak256(abi.encodePacked(word))==answer;
    }

}
