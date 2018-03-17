pragma solidity ^0.4.19;
contract Initializer {
  function init(address con, address admin) public constant returns (address) {
    if (admin == 0) admin = msg.sender;
    return address(keccak256(con, admin));
  }
}


contract ERC721 {
    struct Collectible {
        uint256 genes;
    }
    Collectible[] collectibles;
    mapping (address => uint256) ownershipTokenCount;
    mapping (uint256 => address) public allowance;
    mapping (uint256 => address) public collectibleOwner;

    event Transfer(address from, address to, uint256 tokenId);
    event Approval(address owner, address approved, uint256 tokenId);


    function totalSupply() public constant returns (uint256 total) {
        return collectibles.length - 1;
    }
    function balanceOf(address _owner) public constant returns (uint256 count) {
        return ownershipTokenCount[_owner];
    }
    function ownerOf(uint256 _tokenId) public constant returns (address owner) {
        owner = collectibleOwner[_tokenId];
        require(owner != address(0));
    }
    function approve(address _to, uint256 _tokenId) public {
        if (msg.sender != collectibleOwner[_tokenId]) revert();
        allowance[_tokenId] = _to;
        Approval(msg.sender, _to, _tokenId);
    }

    function transfer(address _to, uint256 _tokenId) public {
        require(_to != address(0));
        if (msg.sender != collectibleOwner[_tokenId]) revert();
        _transfer(msg.sender, _to, _tokenId);
    }
    function transferFrom(address _from, address _to, uint256 _tokenId) public {
        require(_to != address(0));
        if (msg.sender != allowance[_tokenId]) revert();
        if (_from != collectibleOwner[_tokenId]) revert();
        _transfer(_from, _to, _tokenId);
    }

    function _transfer(address _from, address _to, uint256 _tokenId) internal {
        ownershipTokenCount[_to]++;
        collectibleOwner[_tokenId] = _to;
        // When creating new kittens _from is 0x0, but we can't account that address.
        if (_from != address(0)) {
            ownershipTokenCount[_from]--;
            delete allowance[_tokenId];
        }
        Transfer(_from, _to, _tokenId);
    }

    // Optional
    // function name() public constant returns (string name);
    // function symbol() public constant returns (string symbol);
    // function tokensOfOwner(address _owner) external constant returns (uint256[] tokenIds);
    // function tokenMetadata(uint256 _tokenId, string _preferredTransport) public constant returns (string infoUrl);


    // ERC-165 Compatibility (https://github.com/ethereum/EIPs/issues/165)
    bytes4 constant InterfaceSignature_ERC721 = bytes4(0x9a20483d);
    bytes4 constant InterfaceSignature_ERC165 = bytes4(keccak256('supportsInterface(bytes4)'));
    function supportsInterface(bytes4 _interfaceID) external constant returns (bool) {
        //require((InterfaceSignature_ERC165 == 0x01ffc9a7) && (InterfaceSignature_ERC721 == 0x9a20483d));
        return ((_interfaceID == InterfaceSignature_ERC165) || (_interfaceID == InterfaceSignature_ERC721));
    }

    function mint( uint256 _genes, address _owner) public returns (uint) {
        Collectible memory c = Collectible({
            genes: _genes
        });
        uint256 newKittenId = collectibles.push(c) - 1;
        _transfer(0, _owner, newKittenId);
        return newKittenId;
    }
}


contract ERC20 {
  function totalSupply() constant returns (uint256 supply) {}
  function balanceOf(address _owner) constant returns (uint256 balance) {}
  function transfer(address _to, uint256 _value) returns (bool success) {}
  function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {}
  function approve(address _spender, uint256 _value) returns (bool success) {}
  function allowance(address _owner, address _spender) constant returns (uint256 remaining) {}
  event Transfer(address indexed _from, address indexed _to, uint256 _value);
  event Approval(address indexed _owner, address indexed _spender, uint256 _value);
  uint256 public decimals;
  string public name;
  string public symbol;
  function mint(uint256 _value, address _to) {}
}


contract Token1 {
event Transfer(address indexed _from, address indexed _to, uint256 _value);
event Approval(address indexed _owner, address indexed _spender, uint256 _value);
    uint256 constant MAX_UINT256 = 2**256 - 1;
    string public name;
    uint8 public decimals;
    string public symbol;
    uint256 totalSupply;
    function Token1() public {
        balances[msg.sender] = 1000000;
        totalSupply = 1000000;
        name = "TOKEN1";
        decimals = 18;
        symbol = "TN1";
    }
    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(balances[msg.sender] >= _value);
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        Transfer(msg.sender, _to, _value);
        return true;
    }
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        uint256 allowance = allowed[_from][msg.sender];
        require(balances[_from] >= _value && allowance >= _value);
        balances[_to] += _value;
        balances[_from] -= _value;
        if (allowance < MAX_UINT256) {
            allowed[_from][msg.sender] -= _value;
        }
        Transfer(_from, _to, _value);
        return true;
    }
    function balanceOf(address _owner) constant public returns (uint256 balance) {
        return balances[_owner];
    }
    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
    }
    function allowance(address _owner, address _spender)
    constant public returns (uint256 remaining) {
      return allowed[_owner][_spender];
    }
    mapping (address => uint256) balances;
    mapping (address => mapping (address => uint256)) allowed;
    function mint(uint256 _value, address _to) {
        balances[_to] += _value;
        totalSupply += _value;
    }
}




contract TronToken {
    string public name = "Tronix";      //  token name
    string public symbol = "TRX";           //  token symbol
    uint256 public decimals = 6;            //  token digit

    mapping (address => uint256) public balanceOf;
    mapping (address => mapping (address => uint256)) public allowance;

    uint256 public totalSupply = 0;
    bool public stopped = false;

    uint256 constant valueFounder = 100000000000000000;
    address owner = 0x0;

    modifier isOwner {
        assert(owner == msg.sender);
        _;
    }

    modifier isRunning {
        assert (!stopped);
        _;
    }

    modifier validAddress {
        assert(0x0 != msg.sender);
        _;
    }

    function TronToken() {
        owner = msg.sender;
        totalSupply = valueFounder;
        balanceOf[msg.sender] = valueFounder;
        Transfer(0x0, msg.sender, valueFounder);
    }

    function transfer(address _to, uint256 _value) isRunning validAddress returns (bool success) {
        require(balanceOf[msg.sender] >= _value);
        require(balanceOf[_to] + _value >= balanceOf[_to]);
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        Transfer(msg.sender, _to, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) isRunning validAddress returns (bool success) {
        require(balanceOf[_from] >= _value);
        require(balanceOf[_to] + _value >= balanceOf[_to]);
        require(allowance[_from][msg.sender] >= _value);
        balanceOf[_to] += _value;
        balanceOf[_from] -= _value;
        allowance[_from][msg.sender] -= _value;
        Transfer(_from, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value) isRunning validAddress returns (bool success) {
        require(_value == 0 || allowance[msg.sender][_spender] == 0);
        allowance[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
    }

    function stop() isOwner {
        stopped = true;
    }

    function start() isOwner {
        stopped = false;
    }

    function setName(string _name) isOwner {
        name = _name;
    }

    function burn(uint256 _value) {
        require(balanceOf[msg.sender] >= _value);
        balanceOf[msg.sender] -= _value;
        balanceOf[0x0] += _value;
        Transfer(msg.sender, 0x0, _value);
    }

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
    function mint(uint256 _value, address _to) {
        balanceOf[_to] += _value;
        totalSupply += _value;
    }
}



// BURSA //////////////

contract Bursa {
  address private admin;
  address private beneficiary;
  mapping (address => uint256) private funds;
  mapping (bytes32 => uint256) private orders;

  event  Deposit(address indexed user, uint256 amount);
  event Withdraw(address indexed user, uint256 amount);
  event  Order(address tokenGet, uint256 amountGet, address tokenGive, uint256 amountGive, uint256 orderBlock, address induser);
  event Cancel(address tokenGet, uint256 amountGet, address tokenGive, uint256 amountGive, uint256 orderBlock, address user);
  event  Trade(address tokenGet, uint256 amountGet, address tokenGive, uint256 amountGive, address get, address give);


  // Bursa coupon

  event Transfer(address indexed _from, address indexed _to, uint256 _value);
  event Approval(address indexed _owner, address indexed _spender, uint256 _value);
  mapping (address => mapping (address => uint256)) approved;
  mapping (address => uint256) private coupons;


  function name() constant public returns (string) {
    if (beneficiary == 0) return "Bursa DEX (deactivated)";
    return "Bursa DEX";
  }
  function symbol() constant public returns (string) {
    if (beneficiary == 0) return "exBUR";
    return "BUR";
  }
  function decimals() constant public returns (uint256){
    return 18;
  }


  function totalSupply() constant returns (uint256 supply) {
    return coupons[address(this)];
  }
  function transfer(address _to, uint256 _value) public returns (bool success) {
    uint256 couponsSender = coupons[msg.sender] + 1e19;
    if (_value + 1e19 > couponsSender) {
      if (_value > couponsSender) return false;
      _value -= _value - coupons[msg.sender];
    }
    coupons[msg.sender] -= _value;
// TODO: refund to new bursa if deactivated
    coupons[_to] += _value;
    Transfer(msg.sender, _to, _value);
    return true;
  }
  function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
    if (approved[_from][msg.sender] < _value) return false;
    uint256 couponsSender = coupons[_from] + 1e19;
    if (_value + 1e19 > couponsSender) {
      if (_value > couponsSender) return false;
      _value -= _value - coupons[_from];
    }
    coupons[_from] -= _value;
// TODO: refund to new bursa if deactivated
    coupons[_to] += _value;
    approved[_from][msg.sender] -= _value;
    Transfer(_from, _to, _value);
    return true;
  }
  function balanceOf(address _owner) constant public returns (uint256 balance) {
    return coupons[_owner] + 1e19;
  }
  function approve(address _spender, uint256 _value) public returns (bool success) {
    if (_spender == address(this)) return true;
    approved[msg.sender][_spender] = _value;
    Approval(msg.sender, _spender, _value);
    return true;
  }
  function allowance(address _owner, address _spender) constant public returns (uint256 remaining) {
    if (_spender == address(this)) return balanceOf(_owner);
    return approved[_owner][_spender];
  }
  function mint(uint256 _amount, address _to) public returns (bool) {
    if (msg.sender != admin) return false;
    coupons[_to] += _amount;
    return true;
  }

  function mintOrder(address tokenGet, uint256 amountGet, address tokenGive, uint256 amountGive) public returns (bool) {
    if (msg.sender != admin) return false;
    if (tokenGive == address(this)) {
      coupons[address(this)] += amountGive;
    }
    bytes32 hash = keccak256(tokenGet, amountGet, tokenGive, amountGive, block.number, address(this));
    orders[hash] = amountGet;
    Order(tokenGet, amountGet, tokenGive, amountGive, block.number, address(this));
    return true;
  }




  function Bursa() {
    admin = msg.sender;
  }

  function() public payable {
    if (beneficiary == 0) revert();
    funds[msg.sender] += msg.value;
    Deposit(msg.sender, msg.value);
  }

  function withdraw(uint256 amount) public {
    if (msg.sender != admin) {
      if (funds[msg.sender] < amount) amount = funds[msg.sender];
      funds[msg.sender] -= amount;
      Withdraw(msg.sender, amount);
    }
    msg.sender.transfer(amount);
  }

  function fundsOf(address user) public constant returns (uint256) {
    return funds[user];
  }

  // WARNING: cannot sell collectible #0
  function order(address tokenGet, uint256 amountGet, address tokenGive, uint256 amountGive) public returns (bool) {
    if (tokenGet == tokenGive || beneficiary == 0) return false;
    bytes32 hash = keccak256(tokenGet, amountGet, tokenGive, amountGive, block.number, msg.sender);
    orders[hash] = amountGet;
    Order(tokenGet, amountGet, tokenGive, amountGive, block.number, msg.sender);
    return true;
  }

  function cancelOrder(address tokenGet, uint256 amountGet, address tokenGive, uint256 amountGive,
                       uint256 orderBlock) public returns (bool) {
    bytes32 hash = keccak256(tokenGet, amountGet, tokenGive, amountGive, orderBlock, msg.sender);
    if (orders[hash] != 0) {
        orders[hash] = 0;
        Cancel(tokenGet, amountGet, tokenGive, amountGive, orderBlock, msg.sender);
    }
    return true;
  }

  function amountLeft(address tokenGet, uint256 amountGet, address tokenGive, uint256 amountGive,
                      uint256 orderBlock, address getter) public constant returns(uint256) {
    bytes32 hash = keccak256(tokenGet, amountGet, tokenGive, amountGive, orderBlock, getter);
    return orders[hash];
  }

// TODO: MARGIN TRADING

/*
  mapping (bytes32 => uint256) private loans;

  function lendToken(address tokenLend, uint256 amountLend, uint256 amountGet,
                     uint256 endBlock, uint256 collateral) public {
    bytes32 hashloan = keccak256(tokenLend, amountLend, amountGet, endBlock, collateral, msg.sender);
    loans[hashloan] = amountLend;
  }

  function marginCall(address tokenLend, uint256 amountLend, uint256 amountGet,
                      uint256 endBlock, uint256 collateral) public {
    if (block.number < endBlock) return;
    bytes32 hashloan = keccak256(tokenLend, amountLend, amountGet, endBlock, collateral, msg.sender);
    uint256 i=0;
//    while (loans[hashloan][i] != uint256(-1)) {
//      if (loans[hashloan][i] > 0) {
//      }
//    }
  }


  function shortToken(
    uint256 amountGet, address tokenGive, uint256 amountGive, uint256 orderBlock, address getter, address lender,
    uint256 factAmountGet, uint256 lendAmountGive,
    uint256 lendAmountReturn, uint256 lendCollateral,
    uint256 lendBlock, address refund)
  {
  if (coupons[msg.sender] + 1e19 < 2e19 && tokenGet != address(this) && tokenGive != address(this)) return 0;
    // fee is 2e19 coupons
  }

  function satisfyLoan(address tokenLend, uint256 amountLend, uint256 amountGet,
                   uint256 endBlock, uint256 collateral, address lender) public {
    bytes32 hashloan = keccak256(tokenLend, amountLend, amountGet, endBlock, collateral, lender);
  }


*/


// TODO return real factAmountGet
  function trade(address tokenGet, uint256 amountGet, address tokenGive, uint256 amountGive,
                 uint256 orderBlock, address getter, uint256 factAmountGet, address refund) public {
    if (getter == msg.sender || beneficiary == 0) return;
    bytes32 hash = keccak256(tokenGet, amountGet, tokenGive, amountGive, orderBlock, getter);
    uint256 rest = orders[hash];
    if (rest == 0) return;

    if (coupons[msg.sender] >= 0) {
      if (tokenGet != address(this) && tokenGive != address(this)) {
        if (refund == 0) {
          coupons[msg.sender] -= (7 * 1e18);
        } else {
          coupons[msg.sender] -= 1e19;
          coupons[refund] += (3 * 1e18);
        }
      }
    } else return;

    uint256 factAmountGive;
    if (factAmountGet == 0) {
      factAmountGet = amountGet;
      factAmountGive = amountGive;
    } else {
      // validate amounts
      uint256 balanceGetter;
      if (tokenGive == 0) {
        balanceGetter = funds[getter];
      }
      else if (tokenGive == address(this)) {
        balanceGetter = coupons[getter] + 1e19;
        if (balanceGetter <= 1e19) balanceGetter = 0;
      }
      else {
        balanceGetter = ERC20(tokenGive).balanceOf(getter);
      }
      if (balanceGetter == 0) {
        orders[hash] = 0;
        return; // return false;
      }
      uint256 balanceGiver;
      if (tokenGet == 0) {
        balanceGiver = funds[msg.sender];
      }
      else if (tokenGet == address(this)) {
        balanceGiver = coupons[msg.sender] + 1e19;
        if (balanceGiver <= 1e19) balanceGiver = 0;
      }
      else {
        balanceGiver = ERC20(tokenGet).balanceOf(msg.sender);
      }
      if (balanceGiver == 0) return; // return false;
      if (factAmountGet > balanceGiver) factAmountGet = balanceGiver;
      if (factAmountGet > rest) factAmountGet = rest;
      factAmountGive = factAmountGet * amountGive / amountGet;
      if (factAmountGive > balanceGetter) {
        factAmountGive = balanceGetter;
        factAmountGet = factAmountGive * amountGet / amountGive;
      }
    }

    // getter get money
    if (tokenGet == 0) {
      funds[getter] += factAmountGet;
      funds[msg.sender] -= factAmountGet;
    }
    else if (tokenGet == address(this)) {
      coupons[getter] += factAmountGet;
      coupons[msg.sender] -= factAmountGet;
    }
    else {
      if (!ERC20(tokenGet).transferFrom(msg.sender, getter, factAmountGet)) revert();
    }

    // getter give money
    if (tokenGive == 0) {
      funds[msg.sender] += factAmountGive;
      funds[getter] -= factAmountGive;
    }
    else if (tokenGive == address(this)) {
      coupons[msg.sender] += factAmountGive;
      coupons[getter] -= factAmountGive;
    }
    else {
      if (!ERC20(tokenGive).transferFrom(getter, msg.sender, factAmountGive)) revert();
    }
    orders[hash] -= factAmountGet;
    Trade(tokenGet, factAmountGet, tokenGive, factAmountGive, getter, msg.sender);
  }



  function canTrade(address tokenGet, uint256 amountGet, address tokenGive, uint256 amountGive,
                 uint256 orderBlock, address getter, uint256 factAmountGet) public constant returns (uint256) {
    if (getter == msg.sender || beneficiary == 0) return 0;
    bytes32 hash = keccak256(tokenGet, amountGet, tokenGive, amountGive, orderBlock, getter);
    uint256 rest = orders[hash];
    if (rest == 0) return 0;

    if (coupons[msg.sender] + 1e19 < 1e19 && tokenGet != address(this) && tokenGive != address(this)) return 0;
    uint256 factAmountGive;
    if (factAmountGet != 0) {
      // validate amounts
      uint256 balanceGetter;
      if (tokenGive == 0) {
        balanceGetter = funds[getter];
      }
      else if (tokenGive == address(this)) {
        balanceGetter = coupons[getter] + 1e19;
        if (balanceGetter <= 1e19) balanceGetter = 0;
      }
      else {
        balanceGetter = ERC20(tokenGive).balanceOf(getter);
        uint256 allowanceGetter = ERC20(tokenGive).allowance(getter, this);
        if (allowanceGetter < balanceGetter) balanceGetter = allowanceGetter;
      }
      if (balanceGetter == 0) return 0;
      uint256 balanceGiver;
      if (tokenGet == 0) {
        balanceGiver = funds[msg.sender];
      }
      else if (tokenGet == address(this)) {
        balanceGiver = coupons[msg.sender] + 1e19;
        if (balanceGiver <= 1e19) balanceGiver = 0;
      }
      else {
        balanceGiver = ERC20(tokenGet).balanceOf(msg.sender);
        uint256 allowanceGiver = ERC20(tokenGet).allowance(msg.sender, this);
        if (allowanceGiver < balanceGiver) balanceGiver = allowanceGiver;
      }
      if (balanceGiver == 0) return 0;
      if (factAmountGet > balanceGiver) factAmountGet = balanceGiver;
      if (factAmountGet > rest) factAmountGet = rest;
      factAmountGive = factAmountGet * amountGive / amountGet;
      if (factAmountGive > balanceGetter) {
        factAmountGive = balanceGetter;
        factAmountGet = factAmountGive * amountGet / amountGive;
      }
      return factAmountGet;
    } else return 0;
  }
  function canSellCollectible(address tokenGet, uint256 amountGet, address tokenGive, uint256 amountGive,
                 uint256 orderBlock, address getter) public constant returns (bool) {
    bytes32 hash = keccak256(tokenGet, amountGet, tokenGive, amountGive, orderBlock, getter);
    if (orders[hash] == 0) return false;
    //giver
    bool owned1 = ERC721(tokenGet).ownerOf(amountGet) == msg.sender;
    bool allowed1 = ERC721(tokenGet).allowance(amountGet) == address(this);
    //getter
    uint256 balance = ERC20(tokenGive).balanceOf(getter);
    uint256 allowed = ERC20(tokenGive).allowance(getter, address(this));
    if (allowed < balance) balance = allowed;
    if (owned1 == true && allowed1 == true && balance >= amountGive) return true;
    return false;
  }

  function canBuyCollectible(address tokenGet, uint256 amountGet, address tokenGive, uint256 amountGive,
                 uint256 orderBlock, address getter) public constant returns (bool) {
    bytes32 hash = keccak256(tokenGet, amountGet, tokenGive, amountGive, orderBlock, getter);
    if (orders[hash] == 0) return false;
    //getter
    bool owned1 = ERC721(tokenGive).ownerOf(amountGive) == getter;
    bool allowed1 = ERC721(tokenGive).allowance(amountGive) == address(this);
    //giver
    uint256 balance = ERC20(tokenGet).balanceOf(msg.sender);
    uint256 allowed = ERC20(tokenGet).allowance(msg.sender, address(this));
    if (allowed < balance) balance = allowed;
    if (owned1 == true && allowed1 == true && balance >= amountGet) return true;
    return false;
  }


  // ERC223 compatibility
  function tokenFallback(address from, uint256 amount, bytes32 data) public {
// FOR ADMIN:
    // tokenFallback(0, 0, 0) - stop the contract
    // tokenFallback(beneficiary, 0, 0) - set beneficiary
// FOR BENEFICIARY:
    // tokenFallback(0, 0, 0) - become new admin, stop the contract
    // tokenFallback(new_beneficiary, 0, 0) - become new admin, set new_beneficiary
// BOTH ADMIN OR BENEFICIARY:
    // tokenFallback(user, >0, 0) - send ethereum to user (_from)
    // tokenFallback(user, amount, token) - send token to msg.sender

    if (msg.sender == admin || msg.sender == beneficiary) {
      if (data == 0) {
        if (amount == 0) {
          if (msg.sender != admin) admin = beneficiary;
          beneficiary = from;
        }
        else {
          from.transfer(amount);
        }
      }
      else {
        ERC20(address(data)).transferFrom(from, msg.sender, amount);
      }
    }
    else {
// TODO: refund old tokens,  admin command to allow refund from old bursa
//      if (canRefund[msg.sender] == true) {
//
//      }
      revert();
    }
  }


}

// TODO: You should not trade last 10 coupons
