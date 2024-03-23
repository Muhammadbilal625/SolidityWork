// SPDX-License-Identifier: MIT


pragma solidity 0.8.20;

contract Profile{

    struct UserProfile{
        string displayName;
        string bio;
    }

    mapping(address =>UserProfile) public profiles;

    function setProfile(string memory _displayName,string memory bio) public {

        profiles[msg.sender]=UserProfile(_displayName,bio);
    }
    function getProfile(address _user) public view returns(UserProfile memory){
        return profiles[_user];
    }
    }













