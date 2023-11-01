// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

interface IAction {
    function iAmReady() external pure returns(string memory);
}

abstract contract Whois {
    function whoAmI() public virtual returns(string memory);
}

contract BeyzaOruc {
    function getFullName() public pure returns(string memory){
        return "BeyzaOruc";
    }
}

contract SimpleContract is IAction, Whois, BeyzaOruc {
    
    bool public allowed;
    uint public count;
    int public signedCount;
    //string private errorMessage = "is not allowed";
    //unicode "bu özellik aktif değil" Türkçe karakter kullanımı
    address public owner;
    mapping(address => mapping(address => bool)) public allowance;
    string[2] public errorMessages;
    event ContractCreated(address owner, uint256 creationTime);

    struct Account {
        string name;
        string surname;
        uint256 balance;
    }

    Account public account;
    mapping(address => Account) public accountValues;
    Account[3] public admins;
    uint private index;

    constructor() {
        owner = msg.sender;
        errorMessages[0] = "is not allowed";
        errorMessages[1] = "only owner";
        emit ContractCreated(owner, block.timestamp);
    }

    function getSizeOfErrorMessages() public view returns(uint256) {
        return errorMessages.length;
    }


    function setAllowed(bool _allowed) public {
        allowed = _allowed;
    }

    modifier isAllowed (){
        require(allowance[owner][msg.sender],errorMessages[0]);
        _;
    }

    modifier onlyOwner() {
        require(owner == msg.sender,errorMessages[1]);
        _;
    }

    function oneIncrement() public {
        ++count;
    }

    function increment(uint _increment) public isAllowed {
        count = count + _increment;
    }

    function signedIncrement(int _increment) public {
        signedCount = signedCount + _increment; 
    }
        
    function assignAllowance(address _address) public onlyOwner{
        allowance[owner][_address] = true;
    }

    function assignValue(string memory _name, string memory _surname, uint256 _balance) public {
        account.name = _name;
        account.surname = _surname;
        account.balance = _balance;
    }

    function assignValue2(Account memory _account) public {
        account = _account;
    }

    function getAccount() public view returns(Account memory){
        Account memory _account = account;
        return _account;
    }

    function assignAddressValues(Account memory _account) public {
        accountValues[msg.sender] = _account;
    }

    function addAdmin(Account memory admin) public {
        require(index<3,"Has no slot");
        admins[index++] = admin;
    }

    function getAllAdmins() public view returns(Account[3] memory) {
        Account[3] memory _admins;
        for (uint i=0 ; i<3 ; i++) 
        {
            _admins[i] = admins[i];
        }
        return _admins;

    }
    
    //TASK-3 

    /*function getAllAdmins() public view returns (Account[] memory) {
            Account[] memory _admins = new Account[](admins.length);
            for (uint i = 0; i < admins.length; i++) 
                {
                     _admins[i] = admins[i];
                }
            return _admins;
    }*/

    function iAmReady() external pure returns(string memory){
        return "I am ready";
    }

    function whoAmI() public override pure returns(string memory){
        return "0xBeyzaOruc";
    }
}
