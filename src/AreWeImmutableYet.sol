// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract AreWeImmutableYet {
    /**
     * @notice Returns true if the SELFDESTRUCT opcode is still valid.
     *
     * @dev deploys a contract that selfdestructs when called, and tries to call the contract
     *      Returns False if the call succeeds, since the selfdestruct opcode is still valid
     *      Returns True if the call fails, since the selfdestruct opcode is no longer valid
     */
     */
    function areWeImmutableYet() public payable returns (bool success) {
        ///@solidity memory-safe-assembly
        assembly {
            mstore(0, 0x600b5981380380925939f333FF)
            let addr := create2(0, 19, 13, 0)
            success := not(call(gas(), addr, 0, 0, 0, 0, 0))
        }
    }
}
