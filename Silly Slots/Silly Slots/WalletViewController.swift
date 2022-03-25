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

    
    @IBOutlet weak var firstPasswordField: UITextField!
    
    @IBOutlet weak var confirmPasswordField: UITextField!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func ethSignIn(_ sender: Any) {
        
       let  firstPassword = firstPasswordField.text!
       let confirmPassword = confirmPasswordField.text!
        
        if(firstPassword == confirmPassword) {
            let password = firstPassword
            do {
            let keystore = try EthereumKeystoreV3.init(password: password)
                
                self.performSegue(withIdentifier: "actualWalletSegue", sender: nil)
             } catch {
            // print(error.localizedDescription)
                 
                 print("something went wrong")
             }
            
            
    
        // Generate a new account with its new password.

        }
    }
    
    @IBAction func ethSignUp(_ sender: Any) {
    
        let  firstPassword = firstPasswordField.text!
        let confirmPassword = confirmPasswordField.text!
        // Import an existing account from its private key and set its new password.
        
        
        if(firstPassword == confirmPassword) {
            let password = firstPassword
            
            
            let mnemonic = try! BIP39.generateMnemonics(bitsOfEntropy: 128)!
             let keystore = try! (BIP32Keystore(mnemonics: mnemonic, password: password, mnemonicsPassword: ""))
            
            do{
           let userDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let keystoreManager = KeystoreManager.managerForPath(userDir + "\(keystore)")
           var ks: BIP32Keystore?
           if (keystoreManager?.addresses?.count == 0) {
           let mnemonic = try! BIP39.generateMnemonics(bitsOfEntropy: 256)!
           let keystore = try! (BIP32Keystore(mnemonics: mnemonic, password: password, mnemonicsPassword: ""))
           ks = keystore
           let keydata = try JSONEncoder().encode(ks?.keystoreParams)
               
               FileManager.default.createFile(atPath: userDir + "\(keystore)" , contents: keydata, attributes: nil)
           } else {
           ks = keystoreManager?.walletForAddress((keystoreManager?.addresses! [0])!) as? BIP32Keystore
           }
                guard let myaddress = ks?.addresses?.first else {return}; print(myaddress.address)
           }catch{
           print(error.localizedDescription)
           }
            
            
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
