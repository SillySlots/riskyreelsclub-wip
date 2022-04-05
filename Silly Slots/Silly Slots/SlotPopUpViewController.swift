//
//  SlotPopUpViewController.swift
//  Silly Slots
//
//  Created by Rayven Perkins on 4/2/22.
//

import UIKit
import web3swift

class SlotPopUpViewController: UIViewController {
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var betField: UITextField!
    
    
    let defaults = UserDefaults.standard
    var confirmBool = false
    var count = 0
    
    struct Wallet {
        let address: String
        let data: Data
        let name: String
        let isHD: Bool
    }
    
    struct Verbose {
        static var validate = true
        static var password = String()
        static var amount = String()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        defaults.set(false, forKey: "betConfirmed")
        defaults.set(1, forKey: "countBet")
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
      //  defaults.set(1, forKey: "countBet")
        defaults.set(false, forKey: "betConfirmed")
        defaults.synchronize()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did disappear")
        defaults.set(true, forKey: "betConfirmed")
        defaults.synchronize()
    }
    
    
    
    
    
    @IBAction func confirmAction(_ sender: Any) {
       
        Verbose.amount = betField.text!
        Verbose.password = passwordField.text!
        
        self.dismiss(animated: true, completion: nil)
        
//        defaults.set(true, forKey: "betConfirmed")
////        confirmBool = true
////        count = 1
//        self.performSegue(withIdentifier: "returnSegue", sender: nil)
//        defaults.synchronize()
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
