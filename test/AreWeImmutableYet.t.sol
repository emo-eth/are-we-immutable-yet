// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/AreWeImmutableYet.sol";

contract CounterTest is Test {
    AreWeImmutableYet public counter;

    function setUp() public {
        counter = new AreWeImmutableYet();
    }

    function testAreWeImmutableYet() public {
        assertFalse(counter.areWeImmutableYet());
    }
}
