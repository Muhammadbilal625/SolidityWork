// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// library StorageSlot {
//     // Wrap address in a struct so that it can be passed around as a storage pointer
//     struct AddressSlot {
//         address value;
//     }

//     function getAddressSlot(bytes32 slot)
//         internal
//         pure
//         returns (AddressSlot storage pointer)
//     {
//         assembly {
//             // Get the pointer to AddressSlot stored at slot
//             pointer.slot := slot
//         }
//     }
// }
library StorageSlot{
    struct AddressSlot{
        address value;
    }
    function getAddressSlot(bytes32 slot)internal pure returns(AddressSlot storage pointer){
     assembly{
        pointer.slot:=slot
     }   

    }
}

// contract TestSlot {
//     bytes32 public constant TEST_SLOT = keccak256("TEST_SLOT");

//     function write(address _addr) external {
//         StorageSlot.AddressSlot storage data =
//             StorageSlot.getAddressSlot(TEST_SLOT);
//         data.value = _addr;
//     }

//     function get() external view returns (address) {
//         StorageSlot.AddressSlot storage data =
//             StorageSlot.getAddressSlot(TEST_SLOT);
//         return data.value;
//     }
// }

contract TestSlot{
    bytes32 public constant TEST_SLOT_STRING=keccak256("This_is_Examle_String");

    function write(address _addr) external {
        StorageSlot.AddressSlot storage data=StorageSlot.getAddressSlot(TEST_SLOT_STRING);
        data.value=_addr;
    }
    function get() external view returns(address) {
        return StorageSlot.getAddressSlot(TEST_SLOT_STRING).value;
    }

}
