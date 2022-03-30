Original App Design Project -
===

# Silly Slots

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

* [x] User login
* [x] User is automatically logged out (after swipe up)
* [x] User has to verify the age of the user BEFORE they can create an account
* [x] Make our own server
* [ ] User can view NFTs on their screen
* [ ] User can access their crypto wallet
* [ ] User can access their NFT wallet
* [ ] User can customize app through settings
* [ ] User can spin slot machine
* [ ] User receives something back for winning the slot machine (crypto)
* [ ] App is solana compatible
* [ ] A percentage of the winnings are returned back to each NFT holder (daily, monthly, weekly)
* [ ] App checks if NFTs have been sold/bought by another person
* [ ] Read if user is gambling with NFTs or just with crypto (non-holder vs holder)

**Optional Nice-to-have Stories**

* Sound effects 
* Animations 
* Gifs
* Make the images glow when you win and the images line up  

### 2. Screen Archetypes

* Login screen 
   * user can log into their NFT/ Crypto wallet
   * User can log into their account with our platform
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
| --------- | ---- | ----------- |
| username |	String | 	Unique user id for the user to spin the slot machine |
| password |	String |	Unique key to give the user access to their slot machine profile |
| nftUsername |	String |	The users Near/ Ethereum wallet username |
| nftPass	| String | The users near/ Ethereum key to access their wallet |
| transferNft	| DateTime	| Date when ownership of an NFT is transferred to a new user |
| email | String | Unique user email for the user to sign up for an account | 


### Networking
- [Add list of network requests by screen ]
- Sign Up Screen 

| ParseMethod | Example |
| ----------- | ------- | 
| [Sign up user](https://docs.parseplatform.org/ios/guide/#signing-up)  | Creating a user account |

```
@IB Action func onSignUp(_sender: Any) {
let user = PFUser()
user.username = usernameField.text
user.password = passwordField.text
user.email = emailField.text

user.signUpInBackground  { (success, error) in
	if success {
		self.performSegue(withIdentifier: "loginSegue",
			sender: nil)
	} else {
		print("Error: \(error?.localizedDescription)")

}
```

- Log in Screen

| ParseMethod | Example |
| ----------- | ------- | 
| [Log in user](https://docs.parseplatform.org/ios/guide/#logging-in)  | Loggin in a user account |

```
@IB Action func onSignIn(_sender: Any) {
	let username = usernameField.text!
	let password = passwordField.text!

	PFUser.logInWithUsername(inBackground.username, 
		password: password)
	{ (user, error) in 
		if user! = nil {
			self.performSegue(withIdentifier: "loginSegue",
				sender: nil)
		} else {
			print("Error: \(error?.localizedDescription)")
		}
	}

}
```	


- Crypto Wallet 
  - (Read/GET) Query all NFTs where user is owner 
  
| ParseMethod | Example |
| ----------- | ------- | 
| [Query](https://docs.parseplatform.org/ios/guide/#queries-on-string-values)  | Retrieve the NFTS  |
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

### Milestone 1 gif:
![milestone1gif](https://user-images.githubusercontent.com/98482932/159284783-cc25cdab-dd4d-46bf-8037-10c6d5cdba97.gif)

### Milestone 2 gif:
![4Ekv1UhHMv](https://user-images.githubusercontent.com/98482932/160944778-7dbec1e3-1307-4f30-b965-50eac09f04ca.gif)



