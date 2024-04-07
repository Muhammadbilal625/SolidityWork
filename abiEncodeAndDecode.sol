// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

interface IERC20{

    function transfer(address,uint256) external;

}
contract Token{
    function transfer(address,uint256) external{}
}
contract AbiEncode{
    function test(address _contract,bytes calldata data)external {
        (bool ok,)=_contract.call(data);
        require(ok,"Called Failed");
    }
    function encodeWithSignature(address to,uint256 amount)
    external
    pure
    returns(bytes memory){
        return abi.encodeWithSignature("transfer(address,uint256)",to,amount);

    }
    function encodeWithSelector(address to,uint256 amount)
    external
    pure
    returns(bytes memory){
        return abi.encodeWithSelector(IERC20.transfer.selector,to,amount);

    }
    function encodeCall(address to,uint256 amount)
    external
    pure
    returns(bytes memory){
        return abi.encodeCall(IERC20.transfer,(to,amount));
    }
}


contract AbiDecode {
    struct MyStruct {
        string name;
        uint256[2] nums;
    }

    function encode(
        uint256 x,
        address addr,
        uint256[] calldata arr,
        MyStruct calldata myStruct
    ) external pure returns (bytes memory) {
        return abi.encode(x, addr, arr, myStruct);
    }

    function decode(bytes calldata data)
        external
        pure
        returns (
            uint256 x,
            address addr,
            uint256[] memory arr,
            MyStruct memory myStruct
        )
    {
        // (uint x, address addr, uint[] memory arr, MyStruct myStruct) = ...
        (x, addr, arr, myStruct) =
            abi.decode(data, (uint256, address, uint256[], MyStruct));
    }
}
