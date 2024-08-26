// SPDX-License-Identifier: MIT

 pragma solidity 0.8.24;

  contract Medula {
    address private payable creator;
    address private payable audience;
    address private payable owner;

    error OnlyForCreators();
    error OnlyForAudience();
    error OnlyTheOwner();

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
        bool live;
    }

    mapping (address => uint) private creatorBalance;
    mapping (address => uint) private audienceBalance;
    mapping (address => uint) private ownerMapping;
    mapping (uint256 => Product) public productMap;

    uint private productAdd;

    constructor() public {
        owner = msg.sender;
    }

    function addProduct (
        if(msg.sender = creator) {
            revert OnlyForCreators();
        }
        ProductType _type,
        string memory _creator,
        string memory _name,
        string memory _description
    ) public {

         productMap[productAdd] = Product({
            type: _type;
            creator: _creator;
            name: _name;
            description: _description,
            live: true
         })

         productAdd++;
         
         creatorBalance[msg.sender].push(productAdd);

    }

    function getAllProducts() public view returns (uint256[] memory) {
        if(msg.sender = audience) {
            revert OnlyForAudience();
        }
        uint256[] memory everyProducts = new uint256[](productAdd);

        for (uint256 i = 1; i <= productAdd; i++) {
            everyProducts[i - 1] = i
        }

         return everyProducts;
    }

    function getAProductParticulars(uint256 _itemId) public view returns (
        if(msg.sender = audience) {
            revert OnlyForAudience();
        }
        ProductType _type,
        string memory _creator,
        string memory _name,
        string memory _description
    ) {
        Product memory item = productMap[_itemId];
    }

    function buyProduct(uint256 _itemId) public {
        if(msg.sender = audience) {
            revert OnlyForAudience();
        }

        Product memory item = productMap[_itemId];

        (bool success, ) = item.creator.call{value: msg.value}("");
        require(success, "error - failed transaction");
        
    }

    function removeProduct(uint256 _itemId) public {
        if(msg.sender = owner) {
            revert OnlyTheOwner();
        }
        Product memory item = productMap[_itemId];

        item.live = false;
    }

    function removeCreator(address _creator) public {
        if(msg.sender = owner) {
            revert OnlyTheOwner();
        }
        uint256[] storage creatorItemId = creatorMap[_creator];

        delete creatorItemId[_creator];
    }

    function removeAudience(address _audience) public {
        if(msg.sender = owner) {
            revert OnlyTheOwner();
        }
        uint256[] storage audienceItemId = audienceMap[_audience];

        delete audienceItemId[_audience];
    }


  }