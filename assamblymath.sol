// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract AssemblyIf {
    function yul_if(uint256 x) public pure returns (uint256 z) {
        assembly {
            // if condition = 1 { code }
            // no else
            // if 0 { z := 99 }
            // if 1 { z := 99 }
            if gt(x, 10) 
            { z := 99 }
        }
    }

    function yul_switch(uint256 x) public pure returns (uint256 val) {
        assembly {
            switch x
            case 1 { val := 10 }
            case 2 { val := 20 }
            default { val := 0 }
        }
    }
}
pragma solidity ^0.8.24;
// asembly Loops
contract AssemblyLoop {
    function yul_for_loop() public pure returns (uint256 value) {
        assembly {
            for { let m := 0 } lt(m, 10) { m := add(m, 1) } { value := add(value, 5) }
        }
    }

    function yul_while_loop() public pure returns (uint256 value) {
        assembly {
            let k := 0
            for {} lt(k, 10) {} {
                k := add(k, 1)
                value := add(value, 10)
            }
        }
    }
}
//errors in assembly
contract AssemblyError {
    function yul_revert(uint256 x) public pure {
        assembly {
            // revert(p, s) - end execution
            //                revert state changes
            //                return data mem[pâ¦(p+s))
            if gt(x, 10) { revert(0, 0) }
        }
    }
}

//assambly maths

contract AssemblyMath {
    function yul_add(uint256 x, uint256 y) public pure returns (uint256 z) {
        assembly {
            // x=10
            // y=20
            z := add(x, y) 
            if lt(z, x) { revert(0, 0) }
        }
    }

    function yul_mul(uint256 x, uint256 y) public pure returns (uint256 z) {
        assembly {
            switch x
            case 0 { z := 0 }
            default {
                z := mul(x, y)
                if iszero(eq(div(z, x), y)) { revert(0, 0) }
            }
        }
    }

    // Round to nearest multiple of b
    function yul_fixed_point_round(uint256 x, uint256 b)
        public
        pure
        returns (uint256 z)
    {
        assembly {
            // b = 100
            // x = 90
            // z = 90 / 100 * 100 = 0, want z = 100
            // z := mul(div(x, b), b)

            let half := div(b, 2)
            z := add(x, half)
            z := mul(div(z, b), b)
            // x = 90
            // half = 50
            // z = 90 + 50 = 140
            // z = 140 / 100 * 100 = 100
        }
    }
}



