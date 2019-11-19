pragma solidity ^0.4.8;

contract SmartFinances {
    address owner;
    uint[] deposits;
    uint[] withdrawals;
    address creator;
    
    event LOG(uint[] arr);


    function sendTo(uint amount, address to) public onlyOwner returns (bool)  {
        if (owner.balance < amount) {
            return false;
        } else {
            bool sent = to.send(amount);
            withdrawals.push(amount);
        }
        return true;
    }
    
    function withdraw(uint amount) public onlyOwner returns (bool success)  {
        if (owner.balance < amount) {
            return false;
        } else {
            bool sent = owner.send(amount);
            withdrawals.push(amount);
        }
        return true;
    }

    function deposit()  public payable {
        deposits.push(msg.value);
        
    }
    
    function ShowDepositHistory() onlyOwner {
        LOG(withdrawals);
        LOG(deposits);
    }
    
    function ShowWithdrawalHistory() onlyOwner {
        LOG(withdrawals);
        LOG(deposits);
    }
    
    function ShowFullTransactionHistory() onlyOwner {
        ShowWithdrawalHistory();
        ShowDepositHistory();
    }
    
    function requestMoney(uint amount, address user) payable {}
    
    function initWallet(address _owner){
         owner = _owner;
    }
    
    function getBalance() returns (uint) {
        return address(this).balance;
    }
    
    modifier onlyOwner() {
        if (owner != msg.sender) throw;
        _;
    } 

}