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


Scryptr is a new startup in Toronto that helps newspapers in their editting process by putting all edits on the blockchain to make the entire process open and transparent. To simplify their coding process they created a library to handle strings in solidity. For the purposes of this exercise, we're going to refer to the following open source solidity string library (https://github.com/Arachnid/solidity-stringutils).

Get started.
- Load your string.sol, and essay.sol into the remix ide.

You'll notice that essay.sol, a contract used to handle edits, uses a delegatecalls in its code. 

You are a blockchain developer working with Scryptr. You have been working on an update for the library for a few months now. But !OH NO! Scryptr has had sudden budget cuts and they've had to fire some of its dev team. Unfortunantely, you were fired too. But what about all the work you did ?

Part 1 - The Attacker

Before leaving at the end of the week, you decide to add some malicious code onto the library to make it useless to all clients that use it. 
Having studied about solidity libraries for months, you know that all users of the libraries use `delegatecall` to use execute the library code. 

Add some code to the library to make sure that every function call to the library reverts the transaction.

Once done, deploy your string.sol contract and use the deployed user to test your exploit. You can make a delegatecall to the string contract and guarantee that it will always fail, you have successfully rendered the contract useless to all its clients. 

Part 2 - The ethical Hacker

Knowing that essay contract depends on an external library for all functionality especially, making edits can be very disastrous. What if the library crashes, how would you access essays? The news cycle does not stop !

As a responsible coder, add and implement and function to the essay contract, `export`, that returns the essay strings as output, that DOES NOT use any external libraries. 

This ensures that even if a library crashes or does anything malicious. Yuou can always export your work into a string and continue working on it elsewhere.

Submit your malicious string.sol and safe essay.sol

Recommended reading: 
- https://medium.com/coinmonks/delegatecall-calling-another-contract-function-in-solidity-b579f804178c
- https://github.com/Arachnid/solidity-stringutils
