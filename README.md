Original App Design Project - README Template
===

# Silly SLots

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
There will be 1000 with three different rarities, 600 rare, 300 epic, and 100 legendary. Each NFT rewards their holder with a portion of the profited "house money," and each tier will have a higher percent than the last. Additionally, the holders who wish to gamble can connect their NFT to the website and get the increased percentage of winning that's attached with their rarity. The plan is to do the mint (mint price undecided rn) like a day or even a couple hours before we launch the gambling slot machine website and then whoever minted one could connect their nft to the website to then get the improved odds, otherwise people who don’t have an nft can still play but will get the base odds. We would connect the app to users NFT wallet and give them the ability to gamble their NFT's or house money. The interface would be sleek, simple, and easy to use.

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:**
 Casino Games: Gambling and web 3
 
- **Mobile:**
 This app will also be available as a website and the available features will be the same.  
 
- **Story:**
 Allows user to spin slot machine, if they get certain patterns of images they win a percentage
 of the pot based on what images matched together and how many. The app will then give the user what 
 they earned or take out what the lost from their wallet. The app will force the user to approve removing 
 money from their account before the spin, if they win it is returned to them with what they won, but if 
 they lose the money will go to the house wallet. 
 
- **Market:**
 Any person can use this app, but they have to be of age to have NFT wallet or cypto wallet (18+)
 young people who are into web 3. 
 
- **Habit:**
 How often the app will be used, can be used as often/ unoften as a user wants, 
 you can use the app whenever you feel like it, no notifications will be coming from 
 the app unless we update their wallet with their winnings/ NFT shareholders profits. 
 
- **Scope:**
 Anybody can use it in the beginning, and we could expand with the release of each NFT, 
 eventually be able to put your own NFT in the app and use the slot machine with your NFT's. 
 Users can buy a NFT collection from us (4- pack of NFTs) to use in the slot machine. 

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User login
* Automatic logout (after swipe up) 
* View NFT on screen 
* Access NFT Wallet 
* Settings page
* Spin the slot machine 
* Have to get something back for winning (crypto)
* Has to access crypto wallet 
* Solana compatible 
* Return a percentage of the winnings back to each NFT holder (daily, monthly, weekly basis)
* Check if NFTs have been sold/bought by another person 
* Read if user is gambling with and NFT or just with crypto (non-holder vs holder)
* Make our own server

**Optional Nice-to-have Stories**

* Sound effects 
* Animations 
* Gifs
* Make the images glow when you win and the images line up  

### 2. Screen Archetypes

* Login screen 
   * user can log into their NFT/ Crypto wallet
   * ...
* NFT Wallet
   * User can view current NFTS
   * User can views the current amount of crypto they have
* Slot machine screen 
   * User can spin slot machine 
   * If images line up in slot machine notification goes out about winnings 

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* NFT Wallet 
* Slot Machine screen
* History of winnings 

**Flow Navigation** (Screen to Screen)

* Login screen 
   * slot machine screen
   * ...
* [list second screen here]
   * [list screen navigation here]
   * ...

## Wireframes
![wireframe-sillyslots (1)](https://user-images.githubusercontent.com/98482932/158495030-c15c594e-c890-4180-b857-9f0c7045ed27.png)


### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
[This section will be completed in Unit 9]
### Models
[Add table of models]

| Property | Type | Description |
 --------- | ---- | ----------- |
| username |	String | 	Unique user id for the user to spin the slot machine |
| password |	String |	Unique key to give the user access to their slot machine profile |
| nftUsername |	String |	The users Near/ Ethereum wallet username |
| nftPass	| String | The users near/ Ethereum key to access their wallet |
| transferNft	| DateTime	| Date when ownership of an NFT is transferred to a new user |


### Networking
- [Add list of network requests by screen ]
- Login Screen 
  - (Read/GET) 
- Crypto Wallet 
  - (Read/GET) Query all NFTs where user is owner 
```  
let query = PFQuery(className:"Wallet")
query.whereKey("owner", equalTo: currentUser)
query.order(byDescending: "createdAt")
query.findObjectsInBackground { (wallet: [PFObject]?, error: Error?) in
   if let error = error { 
      print(error.localizedDescription)
   } else if let wallet = wallet {
      print("Successfully retrieved \(posts.count) posts.")
  // TODO: Do something with posts...
   }
}   
```

- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
