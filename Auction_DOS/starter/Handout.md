Files provided: attacker.sol, auction.sol

The goal of this challenge is to understand how Denial of Service (DOS) attacks can occur in a Blockchain system. 

Part 0 - Intro

Theres a new up and coming ecommerce startup in Toronto, CryptoBay. Its like Ebay, but their entire auction and bidding system is done on the blockchain to make the entire process open, transparent and secure (!!!)

Here's how CryptoBay works. When a new item is posted on the website, it sends a request to the backend that creates an auction contract for it.. USer's can bid on the item on the website, these requests make calls to the smart contract on the backend. The person who posted the item can end the auction whenever they want. 
The highest bidder after the auction has ended is declared the winner. And further processing happens on the front end web app. 

Get started.
- Load your setup.json, auction.sol and attacker.sol into the remix ide.
- Play the setup.json transactions and look through the transactions.
- You'll see that an Auction instance has been deployed.

Part 1 - The Attacker

You're a blockchain enthusiast and have been studying about its vulnerabilities and attacks. Recently you studied about the parity wallets attack learned about fucntion modifiers and studied about the DAO attacks and learned about fallback functions. You hear about a new startup in Toronto called CryptoBay. THey boast that their system is 100% secure because its on the blockchain. But having studied about computer security, you know that no system is 100% secure. You decide to take a look see if there are any vulnerabilities you can exploit. 

Get started.
- You are given auction.sol and attacker.sol
- Study auction.sol and try to understand how the bidding system works.
- Your goal is to use attacker.sol to impersonate a bidder and guarantee that you win the auction. (Ps: You don't want to spend a lot of money constantly bidding)
- You can add as much code as you want in attacker.sol 

Hint: Try to look at conditions in the code of the functions and see if you can find a weakness to exploit.

If your code guarantees winning the auction without spending too much money, you have successfully found and exploited a vulerability in CryptoBay's "100% secure" codebase. (You will only need 1 bid)

Part 2 - The Ethical Hacker

After graduating with a CS degree from UofT, you get a job as a at an up and coming ecommerce startup in Toronto, CryptoBay. Its like Ebay, but their entire auction and bidding system is done on the blockchain to make the entire process open, transparent and secure (!!!). In your first week you notice a weird pattern in the auction logs of some products. A majority of the bids don't go through succesfully. You decide to take a look into the problem. 

Get started.
- You notice the vulnerability leaving the Auction open to DOS attacks.
- To fix this you decide to implement a pull payment system for the auction. 
- This means that instead of directly refunding the money to the previous bidder, the contract stores the money for the previous bidder to withdraw on their own.

Essentially
Instead of, 

```
Contract     ----> push money back ----> User
```

We implement
```
Contract      <----- request to withdraw  <---- User
Contract      ----> pulls money out ----> User
```

Your goal is to create a function called `withdraw` in the Auction contract, where a bidders (except the highest bidder) can pull their money out from the contract. One way to do this to store a mapping of addresses to bids. And sedn the bid money back when withdraw is called. 

Also, You will want to fix the function `bid` to prevent the attack in part 1.

If your fix is immune to the attacker from part 1, you have successfully fixed the contract.

Submit attacker.sol and your fixed auction.sol.


