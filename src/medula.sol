// SPDX-License-Identifier: MIT

 pragma solidity 0.8.24;

  contract Medula {
    address public creator;
    address public audience;
    address  private owner;

    error OnlyForCreators();
    error OnlyForAudience();
    error OnlyTheOwner();
    error LessThanPrice();

    enum ProductType {
        video,
        code,
        writing,
        design
    }
//@dev I referenced "ProductType type" and got an error; later figured it should be productType
    struct Product {
        ProductType productType;
        string creator;
        string name; 
        string description;
        bool live;
    }

    mapping (address => uint256[]) private creatorMap;
    mapping (address => uint256[]) private audienceMap;
    mapping (address => uint) private ownerMapping;
    mapping (uint256 => Product) public productMap;

    uint private productAdd;

    constructor() {
        owner == msg.sender;
    }

    function setCreator(address _creator) public {
      creator = _creator;
    }

    function setAudience(address _audience) public {
        audience = _audience;
      }

    function addProduct (
        ProductType _productType,
        string memory _creator,
        string memory _name,
        string memory _description
    ) public {
        if(msg.sender != creator) {
            revert OnlyForCreators();
        }
         productMap[productAdd] = Product({
            productType: _productType,
            creator: _creator,
            name: _name,
            description: _description,
            live: true
         });

         productAdd++;
         
         creatorMap[msg.sender].push(productAdd);

    }

    function getAllProducts() public view returns (uint256[] memory) {
        if(msg.sender != audience) {
            revert OnlyForAudience();
        }
        uint256[] memory everyProducts = new uint256[](productAdd);

        for (uint256 i = 1; i <= productAdd; i++) {
            everyProducts[i - 1] = i;
        }

         return everyProducts;
    }

    function getAProductParticulars(uint256 _itemId) public view returns (
        ProductType _productType,
        string memory _creator,
        string memory _name,
        string memory _description
    ) {
        if(msg.sender != audience) {
            revert OnlyForAudience();
        }
        productMap[_itemId];
    }

    function buyProduct(uint256 _itemId, uint256 price, address payable _creator) public payable {
        if(msg.sender != audience) {
            revert OnlyForAudience();
        }

        if(msg.value < price) {
            revert LessThanPrice();
        }

        // Product memory item = productMap[_itemId];

        (bool success, ) = _creator.call{value: price}("");
        require(success, "error - failed transaction");
        
    }

    function removeProduct(uint256 _itemId) public view {
        if(msg.sender != owner) {
            revert OnlyTheOwner();
        }
        Product memory item = productMap[_itemId];

        item.live = false;
    }

    function removeCreator(address _creator) public {
        if(msg.sender != owner) {
            revert OnlyTheOwner();
        }

        delete creatorMap[_creator];
    }

    function removeAudience(address _audience) public {
        if(msg.sender != owner) {
            revert OnlyTheOwner();
        }

        delete audienceMap[_audience];
    }


  }