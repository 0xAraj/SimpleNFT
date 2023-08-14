//SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract SimpleNFT is ERC721 {
    uint256 s_nftCounter;
    using Strings for uint256;

    string public HAPPY_SVG_URI;
    string public SAD_SVG_URI;

    enum Mood {
        HAPPY,
        SAD
    }
    mapping(uint tokenId => Mood) public s_tokenIdToMood;

    constructor(
        string memory happySvgUri,
        string memory sadSvgUri
    ) ERC721("SimpleNFT", "SNFT") {
        s_nftCounter = 0;
        HAPPY_SVG_URI = happySvgUri;
        SAD_SVG_URI = sadSvgUri;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function mintNFT() public {
        s_tokenIdToMood[s_nftCounter] = Mood.HAPPY;
        _safeMint(msg.sender, s_nftCounter);
        s_nftCounter++;
    }

    function changeMood(uint256 tokenId) public {
        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            s_tokenIdToMood[tokenId] = Mood.SAD;
        } else {
            s_tokenIdToMood[tokenId] = Mood.HAPPY;
        }
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        string memory imageURI;
        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            imageURI = HAPPY_SVG_URI;
        } else {
            imageURI = SAD_SVG_URI;
        }
        string memory metadata = string(
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    abi.encodePacked(
                        '{"name": "',
                        name(),
                        '","description": "An NFT that reflects the owners mood.", "image": "',
                        imageURI,
                        '"}'
                    )
                )
            )
        );

        return metadata;
    }
}
