//
//  WalletViewController.swift
//  Silly Slots
//
//  Created by Rayven Perkins on 3/23/22.
//

import UIKit
import web3swift
import Parse



class WalletViewController: UIViewController {

    let defaults = UserDefaults.standard
    @IBOutlet weak var firstPasswordField: UITextField!
    
    @IBOutlet weak var confirmPasswordField: UITextField!
    
    @IBOutlet weak var privKeyField: UITextField!
    
    
    
    struct Wallet {
        let address: String
        let data: Data
        let name: String
        let isHD: Bool
    }

    struct HDKey {
        let name: String?
        let address: String
    
    }
    
//    class ERC20Token {
//        var name: String
//        var address: String
//        var decimals: String
//        var symbol: String
//    }
    
    let web3 = Web3.InfuraMainnetWeb3()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        defaults.synchronize()
        if(defaults.bool(forKey: "lightModeEnabled")){
            overrideUserInterfaceStyle = .light
           
        }
        else if !(defaults.bool(forKey: "lightModeEnabled")){
            overrideUserInterfaceStyle = .dark
            
        }
    }
    
    @IBAction func ethSignIn(_ sender: Any) {
        
       let  firstPassword = firstPasswordField.text!
       let confirmPassword = confirmPasswordField.text!
        let key = privKeyField.text!
        
        if(firstPassword == confirmPassword) {
            let password = firstPassword
            
          //import account with private key
        
//            let key = "L2HRewdY7SSpB2jjKq6mwLes86umkWBuUSPZWE35Q8Pbbr8wVyss124sf124dfsf" // Some private key
            let formattedKey = key.trimmingCharacters(in: .whitespacesAndNewlines)
            let dataKey = Data.fromHex(formattedKey)!
            let keystore = try! EthereumKeystoreV3(privateKey: dataKey, password: password)!
            let name = "New Wallet"
            let keyData = try! JSONEncoder().encode(keystore.keystoreParams)
            let address = keystore.addresses!.first!.address
            let wallet = Wallet(address: address, data: keyData, name: name, isHD: false)
            
            
            
            //get keystore manager from wallet data
            let data = wallet.data
            let keystoreManager: KeystoreManager
            if wallet.isHD {
                let keystore = BIP32Keystore(data)!
                keystoreManager = KeystoreManager([keystore])
            } else {
                let keystore = EthereumKeystoreV3(data)!
                keystoreManager = KeystoreManager([keystore])
            }
            
            //get private key. probably a feature to add on the actual wallet
            let ethereumAddress = EthereumAddress(wallet.address)!
            let pkData = try! keystoreManager.UNSAFE_getPrivateKeyData(password: password, account: ethereumAddress).toHexString()
            
            
            web3.addKeystoreManager(keystoreManager)
            //initializing the eth addresses
            let coldWalletAddress = EthereumAddress("0x6394b37Cf80A7358b38068f0CA4760ad49983a1B")!
            let contractAddress = EthereumAddress("0xe22b8979739D724343bd002F9f432F5990879901", ignoreChecksum: true)!
            //for the balance
            let walletAddress = EthereumAddress(wallet.address)! // Address which balance we want to know
            let balanceResult = try! web3.eth.getBalance(address: walletAddress)
            let balanceString = Web3.Utils.formatToEthereumUnits(balanceResult, toUnits: .eth, decimals: 3)!
            
            //save password and balance to parse
            let walletStuff = PFObject(className:"walletManagement")
            walletStuff["password"] = password
            walletStuff["balance"] = balanceString
            walletStuff.saveInBackground { (succeeded, error)  in
                if (succeeded) {
                    print("password and balance saved")
                    // The object has been saved.
                } else {
                    print("password and balance has not been saved")
                    // There was a problem, check error.description
                }
            }
            
            
            print(balanceString)
            print("it should have printed")
        }
        
        
        self.performSegue(withIdentifier: "actualWalletSegue", sender: nil)
        
        
    }
    
    @IBAction func ethSignUp(_ sender: Any) {
    
        let  firstPassword = firstPasswordField.text!
        let confirmPassword = confirmPasswordField.text!
        let key = privKeyField.text!
        // Import an existing account from its private key and set its new password.
        
        
        if(firstPassword == confirmPassword) {
            let password = firstPassword
            
            //create account with private key
            let keystore = try! EthereumKeystoreV3(password: password)!
            let name = "New Wallet"
            let keyData = try! JSONEncoder().encode(keystore.keystoreParams)
            let address = keystore.addresses!.first!.address
            let wallet = Wallet(address: address, data: keyData, name: name, isHD: false)
            
          //  web3.addKeystoreManager(keystoreManager)
    
        }
        self.performSegue(withIdentifier: "actualWalletSegue", sender: nil)
        
        
            
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
