Files provided: attacker.sol, auction.sol

The goal of this challenge is to understand how the solidity delegatecall function works.

Part 0 - Intro

`delegatecall` in solidity is a unique way of executing functions from different contracts.
For example. if Contract A executes `x = B.getBalance()` in its code. Presummably and correctly, the variable x hols the balance of contract B. 
This is because A simply made a request to B to execute the `getBalance` code. Once B executed it, it returned the result. The function was execute in the context of B.

```
Contract A {
    function calculate_balance() {
        return B.getBalance();
    }
}

Contract B {
    function getBalance(){
        return my_deposits - my_withdrawals;
    }
}
```


`delegatecall` forces the function to be executed in the context of the current contract (A).
For example. if Contract A executes `B.delegatecall(bytes4(keccak("getBalance()")));`. The code will execute as if it were a function of A, using A's storage and variables. 
i.e. The code will execute as if

```
Contract A {
    function calculate_balance() {
        return my_deposits - my_withdrawals;    // --- !!!!
    }
}

Contract B {
    function getBalance(){
        return my_deposits - my_withdrawals;
    }
}
```

`delegatecall` is useful when contracts want to use different functions from a library. They call simply make a delegate call to the library, instead of coding up the functionality themselves. 


WalletPro is a digital wallet company in Toronto. This year they decided to move transactions onto the blockchain to be more transaprent. To get better functionality their wallets use a library called SmartFinances. SmartFinances is a solidity finance library that provides a lot of useful features to digital wallets such as maintaining deposit history, withdrawal history and much more. 

Get started.
- Load your setup.json, SmartFinance.sol, and Wallet.sol into the remix ide.
- Play the setup.json transactions and look through the transactions.
- You'll see that 5 wallets are deployed and further investigation of the logs will reveal that each wallet has 1 ether.

You are a blockchain developer working with SmartFinances. You have been working on an update for the library for a few months now. But !OH NO! SmartFinances has had sudden budget cuts and they've had to fire some of its dev team. Unfortunantely, you were fired too. But what about all the work you did ?

Part 1 - The Attacker

Before leaving at the end of the week, you decide to add some malicious code onto the library to steal the money from all wallets that use it. 
Having studying about solidity libraries for months, you know that all users of the libraries use `delegatecall` to use execute the library code. 

Add some code to the library to steal all the money from a user's wallet. This code can be triggered when thet withdraw or deposit any money.

Once done, deploy your SmartFinances.sol contract and use the deployed user to test your exploit. If you can steal the 5 ether from the 5 wallets, your exploit works successfully. 

Submit your malicious SmartFinances.sol.

Recommended reading: https://medium.com/coinmonks/delegatecall-calling-another-contract-function-in-solidity-b579f804178c