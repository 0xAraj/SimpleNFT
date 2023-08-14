//SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";

contract SimpleNFT is ERC721 {
    uint256 s_nftCounter;
    using Strings for uint256;

    constructor() ERC721("SimpleNFT", "SNFT") {
        s_nftCounter = 0;
    }

    function _baseURI() internal pure override returns (string memory) {
        return
            "https://ipfs.io/ipfs/QmVc1Hbkk2spXK4C2mkxvdyzke8v6eT5ZFCgrzbVHn8xX3/";
    }

    function mintNFT(uint256 tokenId) public {
        _safeMint(msg.sender, tokenId);
    }

    function tokenURI(
        uint256 tokenId
    ) public pure override returns (string memory) {
        return
            string(abi.encodePacked(_baseURI(), tokenId.toString(), ".json"));
    }
}
