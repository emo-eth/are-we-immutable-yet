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
            // if 0xFF opcode is still valid and does not stop execution, this will revert
            mstore(0, 0x600b5981380380925939f333FF3D3DFD)
            let addr := create2(0, 16, 16, 0)
            weAreImmutable := iszero(call(5010, addr, 0, 0, 0, 0, 0))
        }
    }
}
