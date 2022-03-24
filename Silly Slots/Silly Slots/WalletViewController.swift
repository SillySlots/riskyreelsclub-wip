//
//  WalletViewController.swift
//  Silly Slots
//
//  Created by Rayven Perkins on 3/23/22.
//

import UIKit
import EtherWalletKit

class WalletViewController: UIViewController {
    
    @IBOutlet weak var ethPasswordField: UITextField!
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func ethSignIn(_ sender: Any) {
        // Generate a new account with its new password.
        let password = ethPasswordField.text!
        try? EtherWallet.account.generateAccount(password: password)

        
    }
    
    @IBAction func ethSignUp(_ sender: Any) {
        
        // Import an existing account from its private key and set its new password.
        
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
