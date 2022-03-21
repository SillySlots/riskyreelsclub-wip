//
//  SignUpViewController.swift
//  Silly Slots
//
//  Created by Rayven Perkins on 3/16/22.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {
    @IBOutlet weak var usernameField2: UITextField!
    @IBOutlet weak var passwordField2: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var ageField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func onSignUp(_ sender: Any) {
        
        let ageString = ageField.text!
        let ageInt = Int(ageString)!
        
       // let ageInt: Int? = Int(ageField.text ?? " ")
      //  let ageInt = Int(ageField.text) ?? 0
        
        if(ageInt < 18) {
            print("ERROR: you may not sign up for an account")
            
            self.performSegue(withIdentifier: "popUpSegue", sender: nil)
            
            //fix this so that no segue is performed if the age is below
            
        } else {
        let user = PFUser()
        user.username = usernameField2.text
        user.password = passwordField2.text
        user.email = emailField.text

        user.signUpInBackground  { (success, error) in
            if success {
                self.performSegue(withIdentifier: "loginSegue2",
                    sender: nil)
            } else {
                print("Error: \(error?.localizedDescription)")

                    }
            }

        }
    }
}
