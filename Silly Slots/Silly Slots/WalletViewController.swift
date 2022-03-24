//
//  WalletViewController.swift
//  Silly Slots
//
//  Created by Rayven Perkins on 3/23/22.
//

import UIKit
import EtherWalletKit

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
            try? EtherWallet.account.generateAccount(password: password)
        }
        // Generate a new account with its new password.

        
    }
    
    @IBAction func ethSignUp(_ sender: Any) {
    
        let  firstPassword = firstPasswordField.text!
        let confirmPassword = confirmPasswordField.text!
        // Import an existing account from its private key and set its new password.
        
        
        if(firstPassword == confirmPassword) {
            let password = firstPassword
            
            // perform a segue, popup for the privat key
        }
        //privateKey = the weird long thing u copy
        
        
        
        let password = ethPasswordField.text!
        //try? EtherWallet.account.importAccount(privateKey: "1dcbc1d6e0a4587a3a9095984cf051a1bc6ed975f15380a0ac97f01c0c045062, password: password)
            
            
            
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
