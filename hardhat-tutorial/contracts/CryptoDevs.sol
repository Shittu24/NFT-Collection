// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// IMPORTS
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./IWhitelist.sol";

contract CryptoDevs is ERC721Enumerable, Ownable {
    /**
     * dev _baseTokenTokenURI for computing {tokenURI}
     * token will be concatenation of the `baseURI` and `tokenId`.
     */
    string _baseTokenURI;

    // _price is the amount of one Crypto Dev NFT
    uint256 public _price = 0.01 ether;

    // _pause is used to pause the contract in case of an emergency
    bool public _paused;

    // Maximum number of crypto devs
    uint256 public maxTokenIds = 20;

    // total number of tokenIds minted
    uint256 public tokenIds;

    // Whitelist contract instance
    IWhitelist whitelist;

    // boolean to keep track of whether presale started or not
    bool public presaleStarted;

    // timestamp of when presale will end
    uint256 public presaleEnded;

    modifier onlyWhenNotPaused {
        require(!_paused, "Contract currently paused");
        _;
    }

    /**
     * Constructor for CryptoDevs takes in the baseURI to set _baseTokenURI for the collection,
     * It also initializes an instance of whitelist interface
     */
    constructor(string memory baseURI, address whitelistContract) ERC721("CryptoDevs", "CD") {
        _baseTokenURI = baseURI;
        whitelist = IWhitelist(whitelistContract);
    }

    /**
     * dev startPresale start presale for the whitelisted addresses
     */
    function startPresale() public onlyOwner {
        presaleStarted = true;

        // set presaleEnded time as current timestamp + 5 minutes
        presaleEnded = block.timestamp + 5 minutes;
    }

    /**
     * dev presaleMint allow users mint one NFT per transaction during the presale
     */
    function presaleMint() public payable onlyWhenNotPaused {
        require(presaleStarted && block.timestamp < presaleEnded, "Presale not running");
        require(whitelist.whitelistedAddresses(msg.sender), "Your address is not whitelisted");
        require(tokenIds < maxTokenIds, "Max supply of Crypto Devs exceeded");
        require(msg.value >= _price, "Invalid ether amount sent");
        tokenIds += 1;

        _safeMint(msg.sender, tokenIds);
    }

    /**
     * dev mint allows a usetr to mint one NFT per transaction after presale has ended
     */
    function mint() public payable onlyWhenNotPaused {
        require(presaleStarted && block.timestamp >= presaleEnded, "Presale has not ended YET");
        require(tokenIds < maxTokenIds, "Max supply of Crypto Devs exceeded");
        require(msg.value >= _price, "Invalid ether amount sent");
        tokenIds += 1;

        _safeMint(msg.sender, tokenIds);
    }

    /**
     * dev _baseURI overrides the openzeppelin ERC721 implementation which by default returned an empty string for the baseURI
     */
    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }

    /**
     * dev setPaused makes the contract paused or unpaused
     */
    function setPaused(bool val) public onlyOwner {
        _paused = val;
    }

    /**
     * dev withdraw sebds all the ether in the contract to the owner of the contract
     */
    function withdraw() public onlyOwner {
        address _owner = owner();
        uint256 amount = address(this).balance;
        (bool sent, ) = _owner.call{value: amount}("");
        require(sent, "Failed to send Ether");
    }

    // Function to receive ether without calling the mint function
    receive() external payable {}

    // Fallback function is called when msg.data is not empty
    fallback() external payable {}
}