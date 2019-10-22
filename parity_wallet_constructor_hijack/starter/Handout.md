Files provided: starter.sol, walletLibrary.sol

The goal of this challenge is to understand how the Parity Wallet Hack of November 2017 was done. 
In this assignment, you will be provided with starter code very similar to that of the actual (now deprecated) Parity Wallets.

Part 1 - The Attacker

You have two contracts, Wallet and WalletLibrary. Many Wallets can use methods from the WalletLibrary. An example of how a Wallet calls methods from the WalletLibrary can be found in starter.sol. You read some reddit threads about the parity wallet hacks athat really interested you. 
CryptoWalletsPro is another small company that uses a WalletLibrary in its code. Since all code on the blockchain is open source, you found the source code for their wallets and ther wallet library. You want to try and see if their wallets are have the same vulnerability that Parity wallets did. 
Your goal is to siphon off any and all ether from the WalletLibrary contract
Do your own research online and see `if` you can find use inbuilt solidity functions that may help you.

Steps to get you set up.
- Load your starter.sol, and walletLibrary.sol into remix.
- Deploy walletLibrary with some ether. 
- Now add your code into wallet in starter.sol, deploy your malicious wallet contract, and steal the ether from the walletlibrary.

Hints:
- Study the walletLibrary code, do you see anything strange ?
- Look at how the wallet calls the withdraw fucntion of the walletlibrary. If you are to do anything similar, you will want to use the same kind of call.

Part 2 - The Savior

Being an ethical CS student, you reach out to an engineer at at CryptoWalletsPro and inform them about this vulnerability. They're so glad you came to them with the issue and didn't post it online for the world to see. But they're having trouble figuring it out the fix for this vulnerability. Since, you're the one who found the vulnerability, they are willing to offer your a Bounty of $5,000 if you can figure out a fix too. 

You want this bounty. Your goal is to fix the walletLibrary contract in walletLibrary.sol


These articles may help you get started :)

Parity Attack Post Mortem 
https://www.parity.io/the-multi-sig-hack-a-postmortem/

"I accidentally killed it" 
https://elementus.io/blog/which-icos-are-affected-by-the-parity-wallet-bug/
