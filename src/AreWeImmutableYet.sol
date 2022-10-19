// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/**
 * @title Are We Immutable Yet?
 * @author emo.eth
 * @author brockjelmore
 * @author real_philogy
 *
 * Shamelessly stolen from a tweet by brockjelmore: https://twitter.com/brockjelmore/status/1582789807872221184
 * EIP-4758 case from real_philogy: https://twitter.com/real_philogy/status/1582805460863709185
 */
contract AreWeImmutableYet {
    address public immutable targetAddress;

    constructor() {
        targetAddress = address(
            uint160(
                uint256(
                    keccak256(
                        abi.encodePacked( // pack all inputs to the hash together.
                            hex"ff", // start with 0xff to distinguish from RLP.
                            address(this), // this contract will be the caller.
                            uint256(0), // pass in the supplied salt value.
                            keccak256( // pass in the hash of initialization code.
                            abi.encodePacked(hex"600b5981380380925939f333FF"))
                        )
                    )
                )
            )
        );
    }
    /**
     * @notice Returns True if the SELFDESTRUCT opcode is no longer valid.
     *
     * @dev deploys a contract that selfdestructs when called, and tries to call the contract
     *      Returns False if the call succeeds, since the selfdestruct opcode is still valid
     *      Returns True if the call fails, since the selfdestruct opcode is no longer valid
     */

    function areWeImmutableYet() public returns (bool weAreImmutable) {
        ///@solidity memory-safe-assembly
        assembly {
            mstore(0, 0x600b5981380380925939f333FF)
            let addr := create2(0, 19, 13, 0)
            weAreImmutable := iszero(call(5010, addr, 0, 0, 0, 0, 0))
        }
    }

    /**
     * @notice Returns True if the SELFDESTRUCT opcode no longer halts execution.
     *
     * @dev deploys a contract that selfdestructs when called, and tries to call the contract
     *      Returns False if the call succeeds, since the selfdestruct opcode is still valid and halts execution
     *      Returns True if the call fails, since the call will revert if execution is not halted before the revert
     *      opcode is called
     */
    function areWeImmutableYet4758() public returns (bool weAreImmutable) {
        ///@solidity memory-safe-assembly
        assembly {
            // if 0xFF opcode is still valid and does not stop execution, this will revert
            mstore(0, 0x600b5981380380925939f333FF3D3DFD)
            let addr := create2(0, 16, 16, 0)
            weAreImmutable := iszero(call(5010, addr, 0, 0, 0, 0, 0))
        }
    }

    /**
     * @notice returns True if the target address already has code deployed at it, since it will be destroyed
     *         as part of the call if SELFDESTRUCT still works as expected.
     *
     *         Returns true if target address is not empty, since SELFDESTRUCT should have deleted the code
     *         Returns false if the contract is able to deploy and call SELFDESTRUCT on the contract
     */
    function areWeImmutableYetHalting() public returns (bool weAreImmutable) {
        if (targetAddress.code.length > 0) {
            return true;
        }
        ///@solidity memory-safe-assembly
        assembly {
            mstore(0, 0x600b5981380380925939f333FF)
            let addr := create2(0, 19, 13, 0)
            weAreImmutable := iszero(call(5010, addr, 0, 0, 0, 0, 0))
        }
    }
}
