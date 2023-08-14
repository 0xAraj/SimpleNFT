//SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

import {DeploySimpleNFT} from "../../script/DeploySimpleNFT.s.sol";
import {SimpleNFT} from "../../src/SimpleNFT.sol";
import {Test, console} from "forge-std/Test.sol";

contract SimpleNFTTest is Test {
    SimpleNFT simpleNFT;
    address USER1 = makeAddr("user1");

    function setUp() public {
        DeploySimpleNFT deploySimpleNFT = new DeploySimpleNFT();
        simpleNFT = deploySimpleNFT.run();
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "SimpleNFT";
        string memory actualName = simpleNFT.name();

        assert(
            keccak256(abi.encodePacked(expectedName)) ==
                keccak256(abi.encodePacked(actualName))
        );
    }

    function testMintNFTIsWorking() public {
        vm.prank(USER1);
        simpleNFT.mintNFT(0);
        uint balanceOfMinter = simpleNFT.balanceOf(USER1);

        assert(balanceOfMinter == 1);
    }

    function testTokenURIIsReturningAccordingToTokenId() public view {
        string
            memory expectedURI = "https://ipfs.io/ipfs/QmVc1Hbkk2spXK4C2mkxvdyzke8v6eT5ZFCgrzbVHn8xX3/0.json";

        string memory acturalURI = simpleNFT.tokenURI(0);

        assert(
            keccak256(abi.encodePacked(expectedURI)) ==
                keccak256(abi.encodePacked(acturalURI))
        );
    }
}
