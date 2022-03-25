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
            

            let keystore = try! EthereumKeystoreV3(password: password)!
            let name = "New Wallet"
            let keyData = try! JSONEncoder().encode(keystore.keystoreParams)
            let address = keystore.addresses!.first!.address
            let wallet = Wallet(address: address, data: keyData, name: name, isHD: false)
            
                
//            let keystore = try EthereumKeystoreV3.init(password: password)
//
//                self.performSegue(withIdentifier: "actualWalletSegue", sender: nil)
//             } catch {
//            // print(error.localizedDescription)
//
//                 print("something went wrong")
//             }
            
            
    
        // Generate a new account with its new password.

        }
    }
    
    @IBAction func ethSignUp(_ sender: Any) {
    
        let  firstPassword = firstPasswordField.text!
        let confirmPassword = confirmPasswordField.text!
        // Import an existing account from its private key and set its new password.
        
        
        if(firstPassword == confirmPassword) {
            let password = firstPassword
            
        
    
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
