// SPDX-License-Identifier: MIT

 pragma solidity 0.8.24;

  contract Medula {
    address private payable creator;
    address private payable audience;
    address private payable owner;

    enum ProductType {
        video,
        code,
        writing,
        design
    }

    struct Product {
        ProductType type;
        string creator;
        string name; 
        string description;
    }

    mapping (address => uint) private creatorBalance;
    mapping (address => uint) private audienceBalance;
    mapping (address => uint) private ownerMapping;
    mapping (uint256 => Product) public productMap;

    uint private productId;

    function addProduct (
        ProductType _type,
        string memory _creator,
        string memory _name,
        string memory _description
    ) public {

         productMap[productId] = Product({
            type: _type;
            creator: _creator;
            name: _name;
            description: _description
         })
    }

    function buyProduct() public {
        
    }

    function removeProduct() public {

    }


  }