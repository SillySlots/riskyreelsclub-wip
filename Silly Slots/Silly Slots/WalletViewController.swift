//
//  WalletViewController.swift
//  Silly Slots
//
//  Created by Rayven Perkins on 3/23/22.
//

import UIKit
//import EtherWalletKit
import web3swift


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
        }
        
        
        
        
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
            
            
    
        }
        
        
        
            
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
