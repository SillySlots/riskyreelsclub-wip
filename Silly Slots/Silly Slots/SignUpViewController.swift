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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func onSignUp(_ sender: Any) {
        
        let user = PFUser()
        user.username = usernameField2.text
        user.password = passwordField2.text
        user.email = emailField.text

        user.signUpInBackground  { (success, error) in
            if success {
                self.performSegue(withIdentifier: "loginSegue",
                    sender: nil)
            } else {
                print("Error: \(error?.localizedDescription)")

        
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
