//
//  FirstScreenViewController.swift
//  Silly Slots
//
//  Created by Rayven Perkins on 3/16/22.
//

import UIKit

class FirstScreenViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSingInButton(_ sender: Any) {
        self.performSegue(withIdentifier: "signInSegue", sender: nil)
    }
    
    
    @IBAction func onSignUpButton(_ sender: Any) {
        self.performSegue(withIdentifier: "signUpSegue", sender: nil)
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
