// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/**
 * @title Are We Immutable Yet?
 * @author emo.eth
 * @author brockjelmore
 *
 * Shamelessly stolen from a tweet by brockjelmore: https://twitter.com/brockjelmore/status/1582789807872221184
 */
contract AreWeImmutableYet {
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

    function areWeImmutableYet4758() public returns (bool weAreImmutable) {
        ///@solidity memory-safe-assembly
        assembly {
            mstore(0, 0x600b5981380380925939f333FF)
            let addr := create2(0, 19, 13, 0)
            pop(call(5010, addr, 0, 0, 0, 0, 0))
            weAreImmutable := iszero(addr)
        }
    }
}
