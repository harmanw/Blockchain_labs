Files provided: starter.sol, walletLibrary.sol

The goal of this challenge is to understand the vulnerability behind the Parity Wallet Hack of 2017. 
In this assignment, you will be provided with starter code very similar to that of the actual (now deprecated) Parity Wallets.

Part 0 - Intro

A big use case of the blockchain is anonymous transfer of money (well almost anonymous). People can create Wallet contracts. Much like digital wallets (paypal etc..), these contracts can store money and send it to other wallets. 

Its 2016 and you just heard about Parity's new Wallet being deployed on the blockchain. You read about solidity function modifiers on an ethereum security blog. 
Fucntion modifiers are conditions you can apply onto a solidity function. This can be used to do certain checks before execting the function or to make sure that only users with specific permissions can execute the function. 

For example, in the starter code, the `onlyOwner` function modifier on the `withdraw` function ensures that only the owner of the wallet can withdraw money. 
Also notice that `onlyOwner` is not an inbuilt solidity function, you will find it implemented at the bottom of the code. 

Part 1 - The Attacker

Parity knows that since their product is new, there might be some vulnerabilities. So they made a post on twitter saying that anyone who can find a bug in their wallets and responsibily reports it to them will receive a 2000$ cash reward. Having studied a little bit about the blockchain, you decide to give it a go.

Get started.
- Load your setup.json, wallet_vuln.sol and wallet_atk.sol into the remix ide.
- Play the setup.json transactions and look through the logs.
- You'll see that wallet_vuln has some money in it.
- Your goal is to write some code in the wallet_atk's attack() function and try to steal this money.

Hint: Try to look st the function modifier of each function in wallet_vuln and see if you can get past any of these.

Part 2 - The (Rich) Ethical Hacker

Now that you found a major vulnerability in the Parity Wallet code, you're bound to get the cash reward. Good job. But being blockchain developer, you're interested in knowing if its possible to fix the code. 

- Try to fix the code in wallet_vuln by creating a new funtion modifier and applying it to the required fucntions.
- Check your fix by running the exploit from Part 1 on your code. 

Submit your wallet_atk.sol with the exploit and the fixed wallet_vuln.sol .

These articles may help you get started :)

Parity Attack Post Mortem 
https://www.parity.io/the-multi-sig-hack-a-postmortem/

"I accidentally killed it" 
https://elementus.io/blog/which-icos-are-affected-by-the-parity-wallet-bug/
