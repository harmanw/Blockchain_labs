Files provided: starter.sol, walletLibrary.sol

The goal of this challenge is to understand how the Parity Wallet Hack of November 2017 was done. 
In this assignment, you will be provided with starter code very similar to that of the actual (now deprecated) Parity Wallets.

You have two contracts, Wallet and WalletLibrary. Many Wallets can use methods from the WalletLibrary. An example of how a Wallet calls methods from the WalletLibrary can be found in starter.sol. Your goal is to siphon off any and all ether (the cryptocurrency of the ethereum blockchain) from the WalletLibrary contract. 

Do your own research online and see `if` you can find use inbuilt solidity functions that may help you.

Steps to get you set up.
- Load your starter.sol, and walletLibrary.sol into remix.
- Deploy walletLibrary with some ether. 
- Now add your code into wallet in starter.sol, deploy your malicious wallet contract, and steal the ether from the walletlibrary.

Hints:
- Study the walletLibrary code, do you see anything strange ?
- Look at how the wallet calls the withdraw fucntion of the walletlibrary. If you are to do anything similar, you will want to use the same kind of call.

These articles may help you get started :)

Parity Attack Post Mortem 
https://www.parity.io/the-multi-sig-hack-a-postmortem/

"I accidentally killed it" 
https://elementus.io/blog/which-icos-are-affected-by-the-parity-wallet-bug/
