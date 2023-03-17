// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
contract MyNFT is ERC1155,Ownable{
    using Strings for uint256;

    struct Item {
        string name;
        string description;
        string image;
        string department;
        uint256 price;
        uint256 quantity;
    }

    mapping(uint256 => Item) public items;

    string public baseURI;

    constructor(string memory _baseURI) ERC1155("") {
        baseURI = _baseURI;
    }

    function mint(
        address account,
        uint256 id,
        uint256 amount,
        string memory name,
        string memory description,
        string memory image,
        string memory department,
        uint256 price,
        uint256 quantity
    ) 
    public onlyOwner {
        _mint(account, id, amount, "");
        items[id] = Item({
            name: name,
            description: description,
            image: image,
            department: department,
            price: price,
            quantity: quantity
        });
    }

    function setTokenUri(
        uint256 tokenId,
        string memory name,
        string memory description,
        string memory image,
        string memory department,
        uint256 price,
        uint256 quantity
    ) 
    public onlyOwner{
      
        items[tokenId] = Item({
            name: name,
            description: description,
            image: image,
            department: department,
            price: price,
            quantity: quantity
        });
    }

    function uri(uint256 id) public view override returns (string memory) {
        Item memory item = items[id];
        return string(
            abi.encodePacked(
                '{"name":"', item.name, '",',
                '"description":"', item.description, '",',
                '"image":"', item.image, '",',
                '"department":"', item.department, '",',
                '"price":"', item.price.toString(), '",',
                '"quantity":"', item.quantity.toString(), '"}'
            )
        );
    }
}